extends Node

const Goal := preload('res://src/goal.gd')
const Planner = preload('res://src/planner_3.gd')

var state: Dictionary
var goals: Array
var actions: Array

var _planner := Planner.new()
var _current_goal: Goal
var _current_plan: Dictionary


func _physics_process(delta: float) -> void:
	var goal := find_goal()
	if _current_goal != goal or 'finished' in _current_plan:
		_current_goal = goal
		_current_plan = _planner.find_best_plan(state, actions, goal)
		_current_plan.step = 0
	perform_plan()


func find_plan() -> Dictionary:
	var goal := find_goal()
	return _planner.find_best_plan(state, actions, goal)


func find_goal() -> Goal:
	var valid_goals = goals.filter(func (goal): return goal.is_valid(state))
	var highest_priority_goal: Goal = null
	var highest_priority: int = -1000000000
	for goal: Goal in valid_goals:
		var priority := goal.get_priority(state)
		if priority > highest_priority:
			highest_priority_goal = goal
			highest_priority = priority
	return highest_priority_goal


func perform_plan():
	var action = _current_plan.actions[_current_plan.step]
	if action.perform():
		_current_plan.step += 1
		if _current_plan.step == _current_plan.actions.size():
			_current_plan.finished = true
