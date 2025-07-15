extends Node
class_name UiManagerClass

func _ready() -> void:
	$StateMachine.initialize()

func start_buff(bubble_data: BubbleData) -> void:
	%InGame.start_buff(bubble_data)
	
func finish_buff(bubble_data: BubbleData) -> void:
	%InGame.finish_buff(bubble_data)
