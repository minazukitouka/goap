extends RefCounted

var desired_state: Dictionary


func is_valid(state: Dictionary) -> bool:
	return true


func get_priority(state: Dictionary) -> int:
	return 0
