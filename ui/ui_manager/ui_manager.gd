extends Node
class_name UiManagerClass

func _ready() -> void:
	$StateMachine.initialize()

func start_buff(buff_type: GlobalMappings.BuffType) -> void:
	%InGame.start_buff(buff_type)
	
func finish_buff(buff_type: GlobalMappings.BuffType) -> void:
	%InGame.finish_buff(buff_type)

func on_game_win():
	%InGame.on_game_win()

func on_game_over():
	%InGame.on_game_over()

func get_ui_current_state_name() -> String:
	return $StateMachine.current_state_name

func add_move():
	%InGame.add_move()

func remove_all_moves():
	%InGame.remove_all_moves()
