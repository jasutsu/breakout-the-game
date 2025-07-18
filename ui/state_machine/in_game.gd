extends UiState

var applied_buffs: Dictionary[GlobalMappings.BuffType, TextureRect] = {}
var data: Dictionary[String, GlobalMappings.GamePauseType]

func enter(prev_state: String = "", data: Dictionary = {}) -> void:
	$InGameUi.visible = true
	GameManager.set_time_scale_to_one()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
func exit() -> void:
	$InGameUi.visible = false
	GameManager.set_time_scale_to_zero()

func check_unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		data = {
			"data": GlobalMappings.GamePauseType.PAUSE,
		}
		finished.emit(UiStateNames.IN_GAME_PAUSE, data)

func start_buff(buff_type: GlobalMappings.BuffType) -> void:
	applied_buffs[buff_type] = $InGameUi.add_texture_rect(buff_type)
	
func finish_buff(buff_type: GlobalMappings.BuffType) -> void:
	if not applied_buffs.has(buff_type):
		push_error("No buff found to finish off from UI")
	var texture_node = applied_buffs[buff_type]
	applied_buffs.erase(buff_type)
	$InGameUi.remove_texture_rect(texture_node)

func on_game_win():
	data = {
		"data": GlobalMappings.GamePauseType.GAME_WIN,
	}
	$InGameUi.remove_all_texture_rects()
	finished.emit(UiStateNames.IN_GAME_PAUSE, data)
	
func on_game_over():
	data = {
		"data": GlobalMappings.GamePauseType.GAME_OVER,
	}
	$InGameUi.remove_all_texture_rects()
	finished.emit(UiStateNames.IN_GAME_PAUSE, data)

func add_move():
	$InGameUi.add_move()

func remove_all_moves():
	$InGameUi.remove_all_moves()
