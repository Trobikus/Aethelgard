@tool
class_name Actor
extends CharacterBody3D

@export var gravity: float = 10.0

@export var max_health: int = 100
var current_health: int

@export var max_stamina: float = 100.0
@export var stamina_regeneration: float = 15.0
var current_stamina: float

# A flag to control stamina regeneration, useful for sprinting etc.
var can_regenerate_stamina: bool = true

func _ready():
	# Only run game logic when the game is playing, not in the editor
	if not Engine.is_editor_hint():
		current_health = max_health
		current_stamina = max_stamina

func _physics_process(delta):
	# Only run game logic when the game is playing
	if not Engine.is_editor_hint():
		# Regenerate stamina
		if can_regenerate_stamina and current_stamina < max_stamina:
			current_stamina += stamina_regeneration * delta
			current_stamina = min(current_stamina, max_stamina)

func take_damage(amount: int):
	current_health -= amount
	print(self.name + " took " + str(amount) + " damage. Health is now " + str(current_health))
	if current_health <= 0:
		_die()

# Virtual function to be overridden by child classes
func _die():
	# Default death behavior
	print(self.name + " has died.")
	if not Engine.is_editor_hint():
		queue_free()
