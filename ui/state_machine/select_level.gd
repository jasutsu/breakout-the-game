extends UiState

func enter(prev_state: String = "", data: Dictionary = {}) -> void:
	$SelectLevelUi.visible = true
	
func exit() -> void:
	$SelectLevelUi.visible = false
	
func _on_select_level_ui_back_pressed() -> void:
	finished.emit(UiStateNames.MAIN_MENU)


func _on_select_level_ui_play_pressed() -> void:
	finished.emit(UiStateNames.IN_GAME)
