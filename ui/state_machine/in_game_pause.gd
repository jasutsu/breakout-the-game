extends UiState

func enter(prev_state: String = "", data: Dictionary = {}) -> void:
	$InGamePauseUi.visible = true
	
func exit() -> void:
	$InGamePauseUi.visible = false


func _on_action_button_pressed() -> void:
	finished.emit(UiStateNames.IN_GAME)


func _on_main_menu_pressed() -> void:
	finished.emit(UiStateNames.MAIN_MENU)
