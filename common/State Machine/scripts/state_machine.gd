extends Node

const ControllerStateNames = {
	STATE_A = "State_A",
	STATE_B = "State_B",
}

@export var initial_state_name: String = ControllerStateNames.STATE_A

var current_state: ControllerState
var current_state_name: String
var states: Dictionary[String, ControllerState] = {}

func initialize() -> void:
	var owner: Controller = get_parent() as Controller
	assert(owner != null, "This state machine should have Controller as parent")
	
	for child in get_children():
		if child is ControllerState:
			states[child.name] = child as ControllerState
			states[child.name].finished.connect(_change_state)
			states[child.name].enemy = owner
		else:
			push_error(child.name + " is not ControllerState")
	
	if states.size() > 0:
		current_state_name = states.keys()[0]
		current_state = states.values()[0]
		if initial_state_name != "" and states.has(initial_state_name):
			current_state_name = initial_state_name
			current_state = states[initial_state_name]
		current_state.enter()
	else:
		push_error("No states added in the state machine")

func _process(delta: float) -> void:
	if current_state:
		current_state.update(delta)

func _physics_process(delta: float) -> void:
	if current_state:
		current_state.physics_update(delta)

func _change_state(new_state_name: String, data: Dictionary = {}):
	if not states.has(new_state_name):
		push_error("State " + new_state_name + " does not exist in available states. Transition Cancelled")
		return
	
	if current_state:
		current_state.exit()
	var old_state_name = current_state_name
	current_state_name = new_state_name
	current_state = states[new_state_name]
	if current_state:
		current_state.enter(old_state_name, data)
