extends ControllerState

func enter(prev_state: String = "", data: Dictionary = {}) -> void:
	controller.some_function()

func update(delta: float) -> void:
	if controller.some_condition():
		finished.emit(ControllerStateNames.STATE_A)

func exit():
	controller.cleanup()
