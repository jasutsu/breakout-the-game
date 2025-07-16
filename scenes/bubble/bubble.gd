extends Area2D
class_name Bubble

@export var buff_type: GlobalMappings.BuffType

signal bubble_captured(buff_type: GlobalMappings.BuffType)

func initialize() -> void:
	if not buff_type:
		push_error("No buff type assigned to bubble")

	$Sprite2D.texture = GlobalMappings.BubbleResources[buff_type].texture
	scale *= GlobalMappings.BubbleResources[buff_type].size
	
	var buff_manager: BuffManager = get_parent() as BuffManager
	bubble_captured.connect(buff_manager.start_buff)

func _process(delta: float) -> void:
	if buff_type != null:
		position += Vector2.DOWN * GlobalMappings.BubbleResources[buff_type].speed * delta

func _on_body_entered(body: Node2D) -> void:
	bubble_captured.emit(buff_type)
	queue_free()
