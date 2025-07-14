extends UiState

func enter(prev_state: String = "", data: Dictionary = {}) -> void:
	$SettingsUi.visible = true
	
func exit() -> void:
	$SettingsUi.visible = false
	
func _on_settings_ui_back_pressed() -> void:
	finished.emit(UiStateNames.MAIN_MENU)
