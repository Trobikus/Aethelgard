extends Area3D

@export var attack_data: AttackData
@export var speed: float = 20.0
@export var lifetime: float = 3.0 # How long the projectile exists before being freed

func _ready():
	# Set a timer to queue_free the projectile after its lifetime
	var timer = get_tree().create_timer(lifetime)
	timer.timeout.connect(queue_free)
	body_entered.connect(_on_body_entered) # Connects to the signal
	
func _physics_process(delta):
	# Move the projectile in its direction
	global_translate(-global_transform.basis.z * speed * delta)

func _on_body_entered(body):
	if body.is_in_group("enemy"):
		body.take_damage(attack_data.damage)
		SignalBus.enemy_targeted.emit(body.get_instance_id())
		queue_free() # Destroy the projectile on collision
	# If the projectile hits anything else, it will also be destroyed
	# To prevent it from going through walls
	elif not body is Player:
		queue_free()
