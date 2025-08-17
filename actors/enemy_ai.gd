extends Actor

@export var chase_range: float = 10.0
@export var attack_range: float = 2.0
@export var attack_cooldown: float = 1.0
@export var attack_damage: float = 10.0
@export var speed: float = 5.0

var _attack_timer: float = 0.0
var player_node: Node3D # Reference to the player

@onready var nav_agent = $NavigationAgent3D

func _ready():
	super._ready()
	set_physics_process(true) # Enable _physics_process
	health_changed.connect(_on_health_changed)
	player_node = get_tree().get_first_node_in_group("player")

func _physics_process(delta):
	if player_node:
		var distance_to_player = global_transform.origin.distance_to(player_node.global_transform.origin)

		if distance_to_player <= attack_range:
			_attack_player(delta)
		elif distance_to_player <= chase_range:
			_chase_player(delta)
		else:
			_idle(delta)

func _chase_player(delta):
	nav_agent.target_position = player_node.global_transform.origin
	var next_nav_point = nav_agent.get_next_path_position()
	var direction = (next_nav_point - global_transform.origin).normalized()
	velocity = direction * speed
	move_and_slide()

func _attack_player(delta):
	_attack_timer -= delta
	if _attack_timer <= 0:
		player_node.take_damage(attack_damage)
		_attack_timer = attack_cooldown
		print("Enemy attacked player!")

func _idle(delta):
	velocity = Vector3.ZERO
	move_and_slide()

func _on_health_changed(current_health: float, p_max_health: float):
	SignalBus.enemy_health_changed.emit(get_instance_id(), current_health, p_max_health)
