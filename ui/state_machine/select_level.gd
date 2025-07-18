extends UiState

func enter(prev_state: String = "", data: Dictionary = {}) -> void:
	$SelectLevelUi.visible = true
	GameManager.open_or_reload_level(1)
	GameManager.set_time_scale_to_zero()
	update_level_number_text()
	
func exit() -> void:
	$SelectLevelUi.visible = false
	
func _on_select_level_ui_back_pressed() -> void:
	finished.emit(UiStateNames.MAIN_MENU)


func _on_select_level_ui_play_pressed() -> void:
	finished.emit(UiStateNames.IN_GAME)


func _on_select_level_ui_next_pressed() -> void:
	GameManager.load_next_level()
	update_level_number_text()


func _on_select_level_ui_previous_pressed() -> void:
	GameManager.load_previous_level()
	update_level_number_text()

func update_level_number_text():
	$SelectLevelUi.set_level_number_text(GameManager.current_level_number)
