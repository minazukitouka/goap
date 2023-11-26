extends GutTest

const Planner = preload('res://src/planner.gd')

const BuildHouseGoal = preload('res://src/goals/build_house.gd')
const GatherWoodGoal = preload('res://src/goals/gather_wood.gd')
const IdleGoal = preload('res://src/goals/idle.gd')

const FindWoodAction = preload('res://src/actions/find_wood.gd')
const CutWoodAction = preload('res://src/actions/cut_wood.gd')
const ReturnWoodAction = preload('res://src/actions/return_wood.gd')
const BuildHouseAction = preload('res://src/actions/build_house.gd')

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
}


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
