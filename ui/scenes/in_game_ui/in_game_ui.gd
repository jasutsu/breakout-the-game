extends Control

var buff_texture_scene = preload("res://ui/scenes/in_game_ui/buff_texture.tscn")
var move_texture_scene = preload("res://scenes/moves_zone/move_texture.tscn")

func add_texture_rect(buff_type: GlobalMappings.BuffType) -> TextureRect:
	var buff_texture: TextureRect = buff_texture_scene.instantiate()
	buff_texture.texture = GlobalMappings.BubbleResources[buff_type].texture
	%BuffContainer.add_child(buff_texture)
	return buff_texture

func remove_texture_rect(texture_node: Node) -> void:
	texture_node.queue_free()

func add_move() -> void:
	var move_texture = move_texture_scene.instantiate()
	%MovesContainer.add_child(move_texture)

func remove_all_moves() -> void:
	for child in %MovesContainer.get_children():
		child.queue_free()
