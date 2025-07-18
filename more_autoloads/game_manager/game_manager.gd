extends Node

var bubble_scene = preload("res://scenes/bubble/bubble.tscn")

var is_difficulty_easy = true
var current_level_number: int = 1

func spawn_bubble(buff_type: GlobalMappings.BuffType, pos: Vector2) -> void:
	var bubble: Bubble = bubble_scene.instantiate() as Bubble
	bubble.buff_type = buff_type
	bubble.position = pos
	# TODO: add_child is throwing error
	#call_deferred("add_child", bubble)
	var buff_manager: BuffManager = get_tree().get_first_node_in_group("buff_manager") as BuffManager
	buff_manager.add_child(bubble)
	bubble.initialize()

func set_time_scale_to_zero():
	Engine.time_scale = 0.0
	
func set_time_scale_to_one():
	Engine.time_scale = 1.0
	
func set_time_scale_to_slow():
	Engine.time_scale = 0.2

func open_or_reload_level(level_number: int) -> bool:
	var level_path := (
		GlobalMappings.GAME_LEVEL_PATH_PREFIX +
		str(level_number) +	
		GlobalMappings.GAME_LEVEL_PATH_SUFFIX
	)

	if not ResourceLoader.exists(level_path):
		printerr("Level path - " + level_path + " - does not exist")
		return false
	
	var status := get_tree().change_scene_to_file(level_path)
	if status == OK:
		current_level_number = level_number
		return true
	else:
		printerr("Error loading scene at level path - " + level_path)
		return false

func load_next_level() -> bool:
	return open_or_reload_level(current_level_number + 1)

func load_previous_level() -> void:
	open_or_reload_level(current_level_number - 1)

func reload_level() -> void:
	open_or_reload_level(current_level_number)
