extends Node

const UiStateNames = {
	MAIN_MENU = "MainMenu",
	SETTINGS = "Settings",
	SELECT_LEVEL = "SelectLevel",
	IN_GAME = "InGame",
	IN_GAME_PAUSE = "InGamePause",
}

@export var initial_state_name: String = UiStateNames.MAIN_MENU

var current_state: UiState
var current_state_name: String
var states: Dictionary[String, UiState] = {}

func initialize() -> void:
	var owner: UiManagerClass = get_parent() as UiManagerClass
	assert(owner != null, "This state machine should have UiManagerClass")
	
	for child in get_children():
		if child is UiState:
			states[child.name] = child as UiState
			states[child.name].finished.connect(_change_state)
			states[child.name].ui_manager = owner
		else:
			push_error(child.name + " is not UiState")
	
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

func _unhandled_input(event: InputEvent) -> void:
	if current_state:
		current_state.check_unhandled_input(event)

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
