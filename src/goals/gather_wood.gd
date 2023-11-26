extends "res://src/goal.gd"


func is_valid(state: Dictionary) -> bool:
	return 'has_stock_wood' not in state


func get_desired_state(state: Dictionary) -> Dictionary:
	return { has_stock_wood = true }
