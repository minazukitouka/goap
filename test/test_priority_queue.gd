extends GutTest

const PriorityQueue = preload('res://src/priority_queue.gd')


func test_priority_queue():
	var queue = PriorityQueue.new()
	queue.push('A', 5)
	queue.push('B', 3)
	queue.push('C', 6)
	queue.push('D', 5)
	assert_false(queue.is_empty())
	assert_eq(queue.pop(), 'B')
	assert_eq(queue.pop(), 'D')
	assert_eq(queue.pop(), 'A')
	assert_eq(queue.pop(), 'C')
	assert_true(queue.is_empty())
