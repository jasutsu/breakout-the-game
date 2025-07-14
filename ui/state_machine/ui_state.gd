extends Node
class_name UiState

const UiStateNames = {
	MAIN_MENU = "MainMenu",
	SETTINGS = "Settings",
}

signal finished(new_state_name: String, data: Dictionary)

var ui_manager: UiManagerClass

func enter(prev_state: String = "", data: Dictionary = {}) -> void:
	pass
	
func exit() -> void:
	pass

func update(delta: float) -> void:
	pass

func physics_update(delta: float) -> void:
	pass
