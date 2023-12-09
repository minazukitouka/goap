extends "res://src/action.gd"


func _init() -> void:
	name = 'Build House'
	preconditions = { has_stock_wood = true, need_house = true }
	effects = {}


func get_cost(state: Dictionary) -> int:
	return 1


func perform() -> bool:
	print('Building House')
	return true
