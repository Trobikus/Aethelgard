class_name AttackData
extends Resource

@export var damage: float = 10.0
@export var attack_range: float = 1.5 # How far the hitbox extends
@export var duration: float = 0.3 # How long the attack animation/hitbox is active
@export var combo_next_attack_window: float = 0.2 # Time window to press for next combo hit
@export var animation_name: String = "attack_1" # Name of the animation to play
