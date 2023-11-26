extends RefCounted

const Action = preload('res://src/action.gd')
const Goal = preload('res://src/goal.gd')


# plan structure:
# {
#   cost = 3
#   desired_state = { ... }
#   actions = [ ... ]
# }
func find_possible_plans(state: Dictionary, actions: Array, goal: Goal) -> Array:
	var planning_plans = [{
		cost = 0,
		desired_state = goal.get_desired_state(state),
		actions = []
	}]
	var possible_plans = []

	while not planning_plans.is_empty():
		var tail_plan = planning_plans.pop_back()
		for action in actions:
			if action in tail_plan.actions:
				continue
			if not action.is_valid(state):
				continue
			if not can_create_plan_with_action(tail_plan, action, state):
				continue
			var plan = create_plan_with_action(tail_plan, action, state)
			if is_possible_plan(plan, state):
				possible_plans.push_back(plan)
			else:
				planning_plans.push_back(plan)

	return possible_plans


func can_create_plan_with_action(plan: Dictionary, action: Action, state) -> bool:
	var effects = action.get_effects(state)
	for key in effects:
		match effects[key]:
			true:
				if key not in plan.desired_state:
					return false
			false:
				if key in plan.desired_state:
					return false
	return true


func create_plan_with_action(plan: Dictionary, action: Action, state) -> Dictionary:
	var new_plan = {
		cost = plan.cost + action.get_cost(state),
		actions = [action] + plan.actions,
	}
	var desired_state = plan.desired_state.duplicate()
	var effects = action.get_effects(state)
	for key in effects:
		match effects[key]:
			true: desired_state.erase(key)
			false: desired_state[key] = true
	var preconditions = action.get_preconditions(state)
	for key in preconditions:
		match preconditions[key]:
			true: desired_state[key] = true
			false: desired_state.erase(key)
	new_plan.desired_state = desired_state
	return new_plan


func is_possible_plan(plan: Dictionary, state: Dictionary) -> bool:
	for key in plan.desired_state:
		match plan.desired_state[key]:
			true:
				if key not in state:
					return false
			false:
				if key in state:
					return false
	return true
