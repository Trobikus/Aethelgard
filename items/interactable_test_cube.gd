@tool
class_name InteractableTestCube
extends Actor

func _ready():
	add_to_group("interactable")

func interact(interactor: Node):
	# This function is called by the player when they interact.
	# The 'interactor' parameter is the node that initiated the interaction (our player).
	print("I have been interacted with by: " + interactor.name)
	
	# As a test, let's make the cube disappear.
	queue_free()
