extends "res://src/goal.gd"


func _init() -> void:
	desired_state = { need_house = false }


func is_valid(state: Dictionary) -> bool:
	return 'need_house' in state and 'has_stock_wood' in state
