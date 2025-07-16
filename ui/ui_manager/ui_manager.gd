extends Node
class_name UiManagerClass

func _ready() -> void:
	$StateMachine.initialize()

func start_buff(buff_type: GlobalMappings.BuffType) -> void:
	%InGame.start_buff(buff_type)
	
func finish_buff(buff_type: GlobalMappings.BuffType) -> void:
	%InGame.finish_buff(buff_type)
