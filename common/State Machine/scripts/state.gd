extends Node
class_name ControllerState

const ControllerStateNames = {
	STATE_A = "State_A",
	STATE_B = "State_B",
}

signal finished(new_state_name: String, data: Dictionary)

var controller: Controller

func enter(prev_state: String = "", data: Dictionary = {}) -> void:
	pass
	
func exit() -> void:
	pass

func update(delta: float) -> void:
	pass

func physics_update(delta: float) -> void:
	pass
