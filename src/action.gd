extends RefCounted

var name: String
var preconditions: Dictionary
var effects: Dictionary


func is_valid(state: Dictionary) -> bool:
	return true


func get_cost(state: Dictionary) -> int:
	return 100000000000


func _to_string() -> String:
	return "<Action: {0}>".format([name])
