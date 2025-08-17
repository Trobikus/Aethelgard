extends Node

# Player signals
signal player_health_changed(current_health: float, max_health: float)

# Enemy signals
signal enemy_health_changed(enemy_id: int, current_health: float, max_health: float)
signal enemy_targeted(enemy_id: int)
