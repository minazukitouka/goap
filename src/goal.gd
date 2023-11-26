extends RefCounted


func is_valid(state: Dictionary) -> bool:
	return true


func get_priority(state: Dictionary) -> bool:
	return 0


func get_desired_state(state: Dictionary) -> Dictionary:
	return {}
