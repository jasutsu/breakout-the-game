extends UiState

func enter(prev_state: String = "", data: Dictionary = {}) -> void:
	$MainMenuUI.visible = true
	
func exit() -> void:
	$MainMenuUI.visible = false
	
func _on_main_menu_ui_settings_pressed() -> void:
	finished.emit(UiStateNames.SETTINGS)


func _on_main_menu_ui_play_pressed() -> void:
	finished.emit(UiStateNames.SELECT_LEVEL)


func _on_main_menu_ui_quit_pressed() -> void:
	get_tree().quit()
