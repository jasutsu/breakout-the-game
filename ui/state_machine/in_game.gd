extends UiState

var applied_buffs: Dictionary[GlobalMappings.BuffType, TextureRect] = {}

func enter(prev_state: String = "", data: Dictionary = {}) -> void:
	$InGameUi.visible = true
	
func exit() -> void:
	$InGameUi.visible = false

func check_unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		finished.emit(UiStateNames.IN_GAME_PAUSE)

func start_buff(buff_type: GlobalMappings.BuffType) -> void:
	applied_buffs[buff_type] = $InGameUi.add_texture_rect(buff_type)
	
func finish_buff(buff_type: GlobalMappings.BuffType) -> void:
	if not applied_buffs.has(buff_type):
		push_error("No buff found to finish off from UI")
	var texture_node = applied_buffs[buff_type]
	applied_buffs.erase(buff_type)
	$InGameUi.remove_texture_rect(texture_node)
