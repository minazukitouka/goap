extends "res://src/goal.gd"


func is_valid(state: Dictionary) -> bool:
	return 'need_house' in state and 'has_stock_wood' in state


func get_desired_state(state: Dictionary) -> Dictionary:
	return { need_house = false }
