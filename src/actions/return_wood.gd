extends "res://src/action.gd"


func _init() -> void:
	name = 'Return Wood'
	preconditions = { has_gathering_wood = true }
	effects = { has_stock_wood = true }


func get_cost(state: Dictionary) -> int:
	return 1


func perform() -> bool:
	print('Return Wood')
	return true
