extends Control

var buff_texture_scene = preload("res://ui/scenes/in_game_ui/buff_texture.tscn")

func add_texture_rect(bubble_data: BubbleData) -> TextureRect:
	var buff_texture: TextureRect = buff_texture_scene.instantiate()
	buff_texture.texture = bubble_data.texture
	%BuffContainer.add_child(buff_texture)
	return buff_texture

func remove_texture_rect(texture_node: Node) -> void:
	texture_node.queue_free()
