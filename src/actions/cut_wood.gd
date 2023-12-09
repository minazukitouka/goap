extends "res://src/action.gd"


func _init() -> void:
	name = 'Cut Wood'
	preconditions = { can_cut_wood = true }
	effects = { has_gathering_wood = true }


func get_cost(state: Dictionary) -> int:
	return 1


func perform() -> bool:
	print('Cut Wood')
	return true
