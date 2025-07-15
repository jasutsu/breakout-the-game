extends UiState

var applied_buffs: Dictionary[BubbleData, TextureRect] = {}

func enter(prev_state: String = "", data: Dictionary = {}) -> void:
	$InGameUi.visible = true
	
func exit() -> void:
	$InGameUi.visible = false

func check_unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		finished.emit(UiStateNames.IN_GAME_PAUSE)

func start_buff(bubble_data: BubbleData) -> void:
	applied_buffs[bubble_data] = $InGameUi.add_texture_rect(bubble_data)
	
func finish_buff(bubble_data: BubbleData) -> void:
	if not applied_buffs.has(bubble_data):
		push_error("No buff found to finish off from UI")
	var texture_node = applied_buffs[bubble_data]
	applied_buffs.erase(bubble_data)
	$InGameUi.remove_texture_rect(texture_node)
