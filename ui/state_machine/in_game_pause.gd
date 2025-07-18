extends UiState

var pause_type: GlobalMappings.GamePauseType

func enter(prev_state: String = "", data: Dictionary = {}) -> void:
	$InGamePauseUi.visible = true
	pause_type = data["data"] as GlobalMappings.GamePauseType
	var action_text = GlobalMappings.PauseActionText[pause_type]
	$InGamePauseUi.set_action_button_text(action_text)
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
func exit() -> void:
	$InGamePauseUi.visible = false


func _on_action_button_pressed() -> void:
	if pause_type == GlobalMappings.GamePauseType.PAUSE:
		finished.emit(UiStateNames.IN_GAME)
	elif pause_type == GlobalMappings.GamePauseType.GAME_OVER:
		finished.emit(UiStateNames.IN_GAME)
		GameManager.reload_level()
	elif pause_type == GlobalMappings.GamePauseType.GAME_WIN:
		var success: bool = GameManager.load_next_level()
		if success:
			finished.emit(UiStateNames.IN_GAME)
		else:
			finished.emit(UiStateNames.MAIN_MENU)

func _on_main_menu_pressed() -> void:
	finished.emit(UiStateNames.MAIN_MENU)
