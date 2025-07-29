extends Node

var bubble_scene = preload("res://scenes/bubble/bubble.tscn")

var is_difficulty_easy = true
var current_level_number: int = 1

var paddle_hit_count: int = 0
var max_paddle_hit_count: int = 3

const trajectory_length: float = 400.0


func spawn_bubble(buff_type: GlobalMappings.BuffType, pos: Vector2) -> void:
	var bubble: Bubble = bubble_scene.instantiate() as Bubble
	bubble.buff_type = buff_type
	bubble.position = pos
	# TODO: add_child is throwing error
	#call_deferred("add_child", bubble)
	var buff_manager: BuffManager = get_tree().get_first_node_in_group("buff_manager") as BuffManager
	if buff_manager != null:
		buff_manager.add_child(bubble)
		bubble.initialize()

func set_time_scale_to_zero():
	Engine.time_scale = 0.0
	
func set_time_scale_to_one():
	Engine.time_scale = 1.0
	
func set_time_scale_to_slow():
	if paddle_hit_count >= max_paddle_hit_count:
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
		paddle_hit_count = 0
		UiManager.remove_all_moves()
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

func increase_paddle_hit_count() -> void:
	if paddle_hit_count >= max_paddle_hit_count:
		return
	
	paddle_hit_count += 1
	UiManager.add_move()


func remove_moves_effect():
	paddle_hit_count = 0
	GameManager.set_time_scale_to_one()
	UiManager.remove_all_moves()
	var ball_manager: BallManager = get_tree().get_first_node_in_group("ball_manager") as BallManager
	if ball_manager != null:
		ball_manager.unapply_moves_on_all_balls()



func draw_trajectory(start: Vector2, dir: Vector2) -> void:
	return
	if %Trajectory.visible:
		%Trajectory.points[0] = start
		%Trajectory.points[1] = start + dir.normalized() * trajectory_length

func enable_trajectory():
	%Trajectory.visible = true
	
func disable_trajectory():
	%Trajectory.visible = false

func check_trajectory():
	return %Trajectory.visible
