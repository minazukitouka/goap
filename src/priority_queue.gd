extends RefCounted

var _values = []
var _priorities = []


func push(value, priority: int):
	_values.push_back(value)
	_priorities.push_back(priority)
	_heap_up(_values.size() - 1)


func pop():
	var value = _values[0]
	if _values.size() > 1:
		_values[0] = _values.pop_back()
		_priorities[0] = _priorities.pop_back()
		_heap_down(0)
	else:
		_values.clear()
		_priorities.clear()
	return value


func is_empty():
	return _values.is_empty()


func _heap_up(from_index):
	if from_index == 0:
		return
	var parent_index = (from_index - 1) / 2
	if _priorities[parent_index] > _priorities[from_index]:
		_swap(parent_index, from_index)
		_heap_up(parent_index)


func _heap_down(from_index):
	var left_index = from_index * 2 + 1
	var right_index = from_index * 2 + 2
	var minimal_index = from_index
	if left_index < _priorities.size() and _priorities[left_index] < _priorities[minimal_index]:
		minimal_index = left_index
	if right_index < _priorities.size() and _priorities[right_index] < _priorities[minimal_index]:
		minimal_index = right_index
	if minimal_index != from_index:
		_swap(minimal_index, from_index)
		_heap_down(minimal_index)


func _swap(i1, i2):
	var temp_priority = _priorities[i1]
	_priorities[i1] = _priorities[i2]
	_priorities[i2] = temp_priority
	var temp_value = _values[i1]
	_values[i1] = _values[i2]
	_values[i2] = temp_value
