extends Control

@onready var foreground = $Foreground

func update_health_bar(current_health: float, max_health: float):
	if max_health > 0:
		var health_percentage = current_health / max_health
		foreground.scale.x = health_percentage
	else:
		foreground.scale.x = 0
