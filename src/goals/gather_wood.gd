extends "res://src/goal.gd"


func _init() -> void:
	desired_state = { has_stock_wood = true }


func is_valid(state: Dictionary) -> bool:
	return 'has_stock_wood' not in state
