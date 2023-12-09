extends GutTest

const Agent = preload('res://src/agent.gd')

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


func test_find_plan():
	var agent = autofree(Agent.new())
	agent.state = {}
	agent.goals = goals.values()
	agent.actions = actions.values()
	var plan = agent.find_plan()
	assert_eq(plan.cost, 3)
	assert_eq(plan.actions, [
		actions.find_wood,
		actions.cut_wood,
		actions.return_wood
	])


func test_physics_process_1():
	var agent = autofree(Agent.new())
	agent.state = {}
	agent.goals = goals.values()
	agent.actions = actions.values()
	agent._physics_process(0.0)
	assert_eq(agent._current_goal, goals.gather_wood)
	assert_eq(agent._current_plan.step, 1)
	var plan = agent._current_plan
	agent._physics_process(0.0)
	assert_same(agent._current_plan, plan)
	assert_eq(agent._current_plan.step, 2)
	agent._physics_process(0.0)
	assert_same(agent._current_plan, plan)
	assert_eq(agent._current_plan.step, 3)
	assert_eq('finished' in agent._current_plan, true)
	agent._physics_process(0.0)
	assert_not_same(agent._current_plan, plan)


func test_physics_process_2():
	var agent = autofree(Agent.new())
	agent.state = {}
	agent.goals = goals.values()
	agent.actions = actions.values()
	agent._physics_process(0.0)
	assert_eq(agent._current_goal, goals.gather_wood)
	assert_eq(agent._current_plan.step, 1)
	var plan = agent._current_plan
	agent.state = { has_stock_wood = true, need_house = true }
	agent._physics_process(0.0)
	assert_eq(agent._current_goal, goals.build_house)
	assert_not_same(agent._current_plan, plan)
	assert_eq(agent._current_plan.step, 1)


func test_find_goal_1():
	var agent = autofree(Agent.new())
	agent.state = {}
	agent.goals = goals.values()
	assert_eq(agent.find_goal(), goals.gather_wood)


func test_find_goal_2():
	var agent = autofree(Agent.new())
	agent.state = { has_stock_wood = true }
	agent.goals = goals.values()
	assert_eq(agent.find_goal(), goals.idle)


func test_find_goal_3():
	var agent = autofree(Agent.new())
	agent.state = { has_stock_wood = true, need_house = true }
	agent.goals = goals.values()
	assert_eq(agent.find_goal(), goals.build_house)


func test_find_goal_4():
	var agent = autofree(Agent.new())
	agent.state = { need_house = true }
	agent.goals = goals.values()
	assert_eq(agent.find_goal(), goals.gather_wood)
