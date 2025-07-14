extends UiState

func enter(prev_state: String = "", data: Dictionary = {}) -> void:
	$MainMenuUI.visible = true
	
func exit() -> void:
	$MainMenuUI.visible = false
	
func _on_main_menu_ui_settings_pressed() -> void:
	finished.emit(UiStateNames.SETTINGS)
