extends "res://src/action.gd"


func get_cost(state: Dictionary) -> int:
	return 1


func get_preconditions(state: Dictionary) -> Dictionary:
	return { can_cut_wood = true }


func get_effects(state: Dictionary) -> Dictionary:
	return { has_gathering_wood = true }
