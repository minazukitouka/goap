extends "res://src/action.gd"


func _init() -> void:
	name = 'Find Wood'
	preconditions = {}
	effects = { can_cut_wood = true }


func get_cost(state: Dictionary) -> int:
	return 1


func perform() -> bool:
	print('Find Wood')
	return true
