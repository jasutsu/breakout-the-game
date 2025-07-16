extends Node

var bubble_scene = preload("res://scenes/bubble/bubble.tscn")

var is_difficulty_easy = true

func spawn_bubble(buff_type: GlobalMappings.BuffType, pos: Vector2) -> void:
	var bubble: Bubble = bubble_scene.instantiate() as Bubble
	bubble.buff_type = buff_type
	bubble.position = pos
	# TODO: add_child is throwing error
	#call_deferred("add_child", bubble)
	var buff_manager: BuffManager = get_tree().get_first_node_in_group("buff_manager") as BuffManager
	buff_manager.add_child(bubble)
	bubble.initialize()
