class_name Projectile
extends Area3D

@export var speed: float = 20.0
@export var damage: float = 10.0
@export var lifetime: float = 3.0 # How long the projectile exists before being freed

var direction: Vector3

func _ready():
    set_physics_process(true)
    # Connect body_entered signal for collision detection
    body_entered.connect(_on_body_entered)
    # Set a timer to queue_free the projectile after its lifetime
    var timer = get_tree().create_timer(lifetime)
    timer.timeout.connect(queue_free)

func _physics_process(delta):
    # Move the projectile in its direction
    global_translate(direction * speed * delta)

func _on_body_entered(body):
    if body is Actor:
        body.take_damage(damage)
    queue_free() # Destroy the projectile on collision
