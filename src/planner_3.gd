extends RefCounted

const Action = preload('res://src/action.gd')
const Goal = preload('res://src/goal.gd')
const PriorityQueue = preload('res://src/priority_queue.gd')


func find_best_plan(state: Dictionary, actions: Array, goal: Goal) -> Dictionary:
	var planning_plans = PriorityQueue.new()
	planning_plans.push({
		cost = 0,
		desired_state = goal.desired_state,
		actions = []
	}, 0)
	var best_plan

	while not planning_plans.is_empty():
		var tail_plan = planning_plans.pop()
		if best_plan != null and best_plan.cost < tail_plan.cost:
			continue
		for action in actions:
			if action in tail_plan.actions:
				continue
			if not action.is_valid(state):
				continue
			if not can_create_plan_with_action(tail_plan, action, state):
				continue
			var plan = create_plan_with_action(tail_plan, action, state)
			if best_plan == null or best_plan.cost > plan.cost:
				if is_possible_plan(plan, state):
					best_plan = plan
				else:
					planning_plans.push(plan, plan.cost)

	return best_plan


func can_create_plan_with_action(plan: Dictionary, action: Action, state) -> bool:
	var effects = action.effects
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
	var effects = action.effects
	for key in effects:
		match effects[key]:
			true: desired_state.erase(key)
			false: desired_state[key] = true
	var preconditions = action.preconditions
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
