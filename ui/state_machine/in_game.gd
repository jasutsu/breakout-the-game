extends UiState

func enter(prev_state: String = "", data: Dictionary = {}) -> void:
	$InGameUi.visible = true
	
func exit() -> void:
	$InGameUi.visible = false

func check_unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		finished.emit(UiStateNames.IN_GAME_PAUSE)
