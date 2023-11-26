extends RefCounted


func is_valid(state: Dictionary) -> bool:
	return true


func get_cost(state: Dictionary) -> int:
	return 100000000000


func get_preconditions(state: Dictionary) -> Dictionary:
	return {}


func get_effects(state: Dictionary) -> Dictionary:
	return {}
