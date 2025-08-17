@tool
class_name InteractableTestCube
extends Actor

@onready var health_bar: HealthBar3D = $HealthBar3D

func _ready():
	super._ready()
	add_to_group("interactable")
	health_changed.connect(_on_health_changed)
	health_bar.enemy_id = get_instance_id()

func interact(interactor: Node):
	# This function is called by the player when they interact.
	# The 'interactor' parameter is the node that initiated the interaction (our player).
	print("I have been interacted with by: " + interactor.name)
	
	# As a test, let's make the cube disappear.
	queue_free()

func _on_health_changed(current_health: float, p_max_health: float):
	SignalBus.enemy_health_changed.emit(get_instance_id(), current_health, p_max_health)
