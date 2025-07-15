extends Area2D
class_name Bubble

@export var bubble_data: BubbleData

signal bubble_captured(bubble_data: BubbleData)

func instantiate() -> void:
	if not bubble_data:
		push_error("No bubble data in the assigned")

	$Sprite2D.texture = bubble_data.texture
	scale *= bubble_data.size
	
	var buff_manager: BuffManager = get_parent() as BuffManager
	bubble_captured.connect(buff_manager.start_buff)

func _process(delta: float) -> void:
	if bubble_data:
		position += Vector2.DOWN * bubble_data.speed * delta

func _on_body_entered(body: Node2D) -> void:
	print(bubble_data.duration)
	bubble_captured.emit(bubble_data)
	queue_free()
