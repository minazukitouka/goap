extends "res://src/action.gd"


func get_cost(state: Dictionary) -> int:
	return 1


func get_preconditions(state: Dictionary) -> Dictionary:
	return {}


func get_effects(state: Dictionary) -> Dictionary:
	return { can_cut_wood = true }
