extends "res://src/action.gd"


func _init() -> void:
	name = 'Sleep'
	preconditions = {}
	effects = {}


func get_cost(state: Dictionary) -> int:
	return 1


func perform() -> bool:
	print('Sleep')
	return true
