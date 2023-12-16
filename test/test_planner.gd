extends GutTest

const Planner = preload('res://src/planner.gd')
const Planner2 = preload('res://src/planner_2.gd')
const Planner3 = preload('res://src/planner_3.gd')

const BuildHouseGoal = preload('res://src/goals/build_house.gd')
const GatherWoodGoal = preload('res://src/goals/gather_wood.gd')
const IdleGoal = preload('res://src/goals/idle.gd')

const FindWoodAction = preload('res://src/actions/find_wood.gd')
const CutWoodAction = preload('res://src/actions/cut_wood.gd')
const ReturnWoodAction = preload('res://src/actions/return_wood.gd')
const BuildHouseAction = preload('res://src/actions/build_house.gd')
const SleepAction = preload('res://src/actions/sleep.gd')

var goals = {
	build_house = BuildHouseGoal.new(),
	gather_wood = GatherWoodGoal.new(),
	idle = IdleGoal.new(),
}

var actions = {
	find_wood = FindWoodAction.new(),
	cut_wood = CutWoodAction.new(),
	return_wood = ReturnWoodAction.new(),
	build_house = BuildHouseAction.new(),
	#sleep1 = SleepAction.new(),
	#sleep2 = SleepAction.new(),
	#sleep3 = SleepAction.new(),
	#sleep4 = SleepAction.new(),
	#sleep5 = SleepAction.new(),
	#sleep6 = SleepAction.new(),
	#sleep7 = SleepAction.new(),
	#sleep8 = SleepAction.new(),
	#sleep9 = SleepAction.new(),
	#sleep10 = SleepAction.new(),
	#sleep11 = SleepAction.new(),
	#sleep12 = SleepAction.new(),
	#sleep13 = SleepAction.new(),
	#sleep14 = SleepAction.new(),
	#sleep15 = SleepAction.new(),
}


func test_find_best_plan():
	var planner := Planner.new()
	var state := {}
	var goal = goals.gather_wood
	var result = planner.find_best_plan(state, actions.values(), goal)
	assert_eq(result.cost, 3)
	assert_eq(result.actions, [
		actions.find_wood,
		actions.cut_wood,
		actions.return_wood
	])


func test_find_possible_plans_example_1():
	var planner := Planner.new()
	var state := {}
	var goal = goals.gather_wood
	var result = planner.find_possible_plans(state, actions.values(), goal)
	assert_eq(result.size(), 1)
	assert_eq(result[0].cost, 3)
	assert_eq(result[0].actions, [
		actions.find_wood,
		actions.cut_wood,
		actions.return_wood
	])


func test_find_possible_plans_example_2():
	var planner := Planner.new()
	var state := { can_cut_wood = true }
	var goal = goals.gather_wood
	var result = planner.find_possible_plans(state, actions.values(), goal)
	assert_eq(result.size(), 1)
	assert_eq(result[0].cost, 2)
	assert_eq(result[0].actions, [
		actions.cut_wood,
		actions.return_wood
	])


func test_find_possible_plans_example_3():
	var planner := Planner.new()
	var state := {}
	var goal = goals.build_house
	var result = planner.find_possible_plans(state, actions.values(), goal)
	assert_eq(result.size(), 0)


func test_benchmark_planner():
	var planner1 := Planner.new()
	var planner2 := Planner2.new()
	var planner3 := Planner3.new()
	var state := {}
	var goal = goals.gather_wood
	#benchmark('Planner1', func():
		#var result = planner1.find_best_plan(state, actions.values(), goal)
		#assert_eq(result.actions, [
			#actions.find_wood,
			#actions.cut_wood,
			#actions.return_wood
		#])
	#)
	benchmark('Planner2', func():
		var result = planner2.find_best_plan(state, actions.values(), goal)
		assert_eq(result.actions, [
			actions.find_wood,
			actions.cut_wood,
			actions.return_wood
		])
	)
	benchmark('Planner3', func():
		var result = planner3.find_best_plan(state, actions.values(), goal)
		assert_eq(result.actions, [
			actions.find_wood,
			actions.cut_wood,
			actions.return_wood
		])
	)


func benchmark(title, callable: Callable):
	var start_time = Time.get_ticks_usec()
	callable.call()
	var elapsed_time = Time.get_ticks_usec() - start_time
	gut.p('{0} took {1}us'.format([title, elapsed_time]))
