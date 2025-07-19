extends Control

var buff_texture_scene = preload("res://ui/scenes/in_game_ui/buff_texture.tscn")
var move_texture_empty_scene = preload("res://ui/scenes/in_game_ui/move_texture_empty.tscn")
var move_texture_fill_scene = preload("res://ui/scenes/in_game_ui/move_texture_fill.tscn")

var move_index: int = 0

func _ready() -> void:
	reset_all_moves_textures()

func reset_all_moves_textures() -> void:
	move_index = 0
	for i in range(GameManager.max_paddle_hit_count):
		var move_texture_empty = move_texture_empty_scene.instantiate()
		%MovesContainer.add_child(move_texture_empty)

func add_texture_rect(buff_type: GlobalMappings.BuffType) -> TextureRect:
	var buff_texture: TextureRect = buff_texture_scene.instantiate()
	buff_texture.texture = GlobalMappings.BubbleResources[buff_type].texture
	%BuffContainer.add_child(buff_texture)
	return buff_texture

func remove_texture_rect(texture_node: Node) -> void:
	texture_node.queue_free()

func remove_all_texture_rects() -> void:
	for child in %BuffContainer.get_children():
		child.queue_free()

func add_move() -> void:
	var texture_rect: TextureRect = %MovesContainer.get_child(move_index) as TextureRect
	texture_rect.queue_free()
	var move_texture_fill = move_texture_fill_scene.instantiate()
	%MovesContainer.add_child(move_texture_fill)
	%MovesContainer.move_child(move_texture_fill, move_index)
	move_index += 1

func remove_all_moves() -> void:
	for child in %MovesContainer.get_children():
		child.queue_free()
	reset_all_moves_textures()
