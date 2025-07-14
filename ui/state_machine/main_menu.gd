extends UiState

func enter(prev_state: String = "", data: Dictionary = {}) -> void:
	#controller.some_function()
	pass

func update(delta: float) -> void:
	#if controller.some_condition():
		#finished.emit(ControllerStateNames.STATE_B)
	pass
