@tool
class_name Player
extends Actor

# State Machine
enum State { MOVE, DODGE, SPRINT, ATTACK }
var current_state: State = State.MOVE

# Movement variables
@export var speed = 5.0
@export var jump_velocity = 4.5
@export var sprint_speed_multiplier: float = 1.8
@export var sprint_stamina_cost: float = 10.0 # per second

# Dodge variables
@export var dodge_stamina_cost: float = 30.0
@export var dodge_speed: float = 12.0
@export var dodge_duration: float = 0.25

var dodge_timer: float = 0.0
var dodge_direction: Vector3

# Attack variables
@export var base_attack_data: AttackData
@export var max_combo_hits: int = 3 # New variable
var attack_timer: float = 0.0
var attack_combo_counter: int = 0
var can_combo: bool = false

# Camera control variables
@export var mouse_sensitivity = 0.002
@onready var camera_pivot = $CameraPivot
@onready var interaction_raycast = $CameraPivot/Camera3D/InteractionRayCast
@onready var melee_hitbox = $MeleeHitbox

func _ready():
	super() # Calls _ready in Actor
	if not Engine.is_editor_hint():
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	# Exclude the player itself from the raycast
	interaction_raycast.add_exception(self)

	# Connect hitbox signal
	melee_hitbox.body_entered.connect(_on_melee_hitbox_body_entered)

func _unhandled_input(event):
	if not Engine.is_editor_hint():
		if event.is_action_pressed("ui_cancel"):
			if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
				Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			else:
				Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED and event is InputEventMouseMotion:
		rotate_y(-event.relative.x * mouse_sensitivity)
		camera_pivot.rotate_x(-event.relative.y * mouse_sensitivity)
		camera_pivot.rotation.x = clamp(camera_pivot.rotation.x, -PI/2, PI/2)

func _physics_process(delta):
	if not Engine.is_editor_hint():
		# Universal logic (stamina regen) is handled by Actor's _physics_process
		super._physics_process(delta)

		# Apply gravity
		if not is_on_floor():
			velocity.y -= gravity * delta

		# State machine logic
		match current_state:
			State.MOVE:
				_move_state(delta)
			State.DODGE:
				_dodge_state(delta)
			State.SPRINT:
				_sprint_state(delta)
			State.ATTACK:
				_attack_state(delta)
		
		_handle_interaction_check()
		move_and_slide()

# --- Interaction ---
func _handle_interaction_check():
	interaction_raycast.force_raycast_update()
	if interaction_raycast.is_colliding():
		var collider = interaction_raycast.get_collider()
		if collider.is_in_group("interactable"):
			# In the future, we will show a UI prompt here.
			if Input.is_action_just_pressed("interact"):
				# This will error until we create an interactable object
				# with an interact() method.
				collider.interact(self)

# --- State Functions ---

func _move_state(delta):
	# --- Get input --- 
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")

	# --- Check for state transitions ---
	# To Attack
	if Input.is_action_just_pressed("attack"):
		current_state = State.ATTACK
		attack_timer = base_attack_data.duration # Initialize attack timer
		attack_combo_counter = 0 # Reset combo counter
		can_combo = false # Reset can_combo
		return
	# To Sprint
	if Input.is_action_pressed("sprint") and current_stamina > 0 and input_dir != Vector2.ZERO:
		can_regenerate_stamina = false
		current_state = State.SPRINT
		return
	# To Dodge
	if Input.is_action_just_pressed("dodge") and current_stamina >= dodge_stamina_cost and is_on_floor():
		can_regenerate_stamina = true # Ensure stamina regens after dodge
		current_state = State.DODGE
		current_stamina -= dodge_stamina_cost
		dodge_timer = dodge_duration
		
		var input_dir_dodge = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
		if input_dir_dodge != Vector2.ZERO:
			dodge_direction = (transform.basis * Vector3(input_dir_dodge.x, 0, input_dir_dodge.y)).normalized()
		else:
			dodge_direction = -transform.basis.z
		return

	# --- State logic ---
	# Jump
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_velocity

	# Movement
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)

func _dodge_state(delta):
	# --- State logic ---
	velocity.x = dodge_direction.x * dodge_speed
	velocity.z = dodge_direction.z * dodge_speed
	
	dodge_timer -= delta

	# --- Check for state transitions ---
	if dodge_timer <= 0:
		current_state = State.MOVE
		velocity = dodge_direction * speed 

func _sprint_state(delta):
	# --- Get input ---
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")

	# --- Check for state transitions ---
	if not Input.is_action_pressed("sprint") or current_stamina <= 0 or input_dir == Vector2.ZERO:
		can_regenerate_stamina = true
		current_state = State.MOVE
		return

	# --- State logic ---
	# Stamina drain
	current_stamina -= sprint_stamina_cost * delta

	# Movement
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	velocity.x = direction.x * speed * sprint_speed_multiplier
	velocity.z = direction.z * speed * sprint_speed_multiplier

func _attack_state(delta):
	# Manage attack timer
	attack_timer -= delta

	# Activate hitbox only for the duration of the attack
	if attack_timer > base_attack_data.duration - 0.1: # Activate for first 0.1s of attack
		melee_hitbox.set_deferred("monitoring", true)
		melee_hitbox.set_deferred("monitorable", true)
	else:
		melee_hitbox.set_deferred("monitoring", false)
		melee_hitbox.set_deferred("monitorable", false)

	# Check for combo window
	if attack_timer <= base_attack_data.combo_next_attack_window and attack_timer > 0:
		can_combo = true
	else:
		can_combo = false

	# Check for next combo input during combo window
	if can_combo and Input.is_action_just_pressed("attack"):
		attack_combo_counter += 1
		if attack_combo_counter >= max_combo_hits: # Check if max combo reached
			attack_combo_counter = 0 # Reset for next combo sequence
			current_state = State.MOVE # End combo, return to move state
			attack_timer = 0.0 # Ensure timer is reset
			return

		attack_timer = base_attack_data.duration # Reset timer for next hit
		can_combo = false # Consume combo window
		print("Combo hit: ", attack_combo_counter)
		return # Stay in attack state for next combo hit

	# Transition back to MOVE if attack duration ends
	if attack_timer <= 0:
		attack_combo_counter = 0 # Reset combo
		current_state = State.MOVE
		attack_timer = 0.0 # Reset for next attack
		return

# --- Hitbox Signal Function ---
func _on_melee_hitbox_body_entered(body):
	if body is Actor and body != self: # Added 'and body != self'
		body.take_damage(base_attack_data.damage)
		# To prevent multiple hits from one attack, we might disable the hitbox
		# or add a list of already-hit enemies. For now, simple.
		
		# Use set_deferred to avoid "Function blocked during in/out signal" error
		melee_hitbox.set_deferred("monitoring", false)
		melee_hitbox.set_deferred("monitorable", false)

# We override the _die() function to add player-specific death behavior
func _die():
	super._die() # Call parent function first
	print("Player has died. Game Over!")
	if not Engine.is_editor_hint():
		get_tree().reload_current_scene()
