extends Node
class_name  BallManager

var ball_scene = preload("res://scenes/ball/ball.tscn")
var balls: Array[Ball] = []
const max_balls: int = 10

signal game_over

func _ready() -> void:
	game_over.connect(GameManager.set_time_scale_to_zero)
	game_over.connect(UiManager.on_game_over)

func _on_buff_manager_buff_started(buff_type: GlobalMappings.BuffType) -> void:
	if buff_type == GlobalMappings.BuffType.BALL_BIG:
		for ball in balls:
			ball.apply_buff_big_ball()
	elif buff_type == GlobalMappings.BuffType.BALL_FAST:
		for ball in balls:
			ball.apply_buff_fast_ball()
	elif buff_type == GlobalMappings.BuffType.BALL_SPLIT:
		split_ball()

func _on_buff_manager_buff_finished(buff_type: GlobalMappings.BuffType) -> void:
	if buff_type == GlobalMappings.BuffType.BALL_BIG:
		for ball in balls:
			ball.unapply_buff_big_ball()
	elif buff_type == GlobalMappings.BuffType.BALL_FAST:
		for ball in balls:
			ball.unapply_buff_fast_ball()

func spawn_ball(position: Vector2) -> Ball:
	var ball: Ball = ball_scene.instantiate() as Ball
	#call_deferred("add_child", ball)
	add_child(ball)
	ball.position = position
	return ball

func split_ball():
	if balls.size() * 2 >= max_balls:
		return
	var new_balls: Array[Ball] = []
	for ball in balls:
		var direction := ball.linear_velocity.normalized()
		var ball1 = spawn_ball(ball.position)
		ball1.update_direction(direction.rotated(-PI/4))
		var ball2 = spawn_ball(ball.position)
		ball2.update_direction(direction.rotated(PI/4))
		new_balls.append_array([ball1, ball2])
		ball.queue_free()
	balls.clear()
	balls = new_balls

func _on_kill_zone_body_entered(body: Node2D) -> void:
	var index: int = 0
	for i in range(balls.size()):
		if balls[i] == body:
			index = i
			break
	balls.remove_at(index)
	body.queue_free()
	
	var balls_count = balls.size()
	if balls_count <= 0:
		game_over.emit()


func _on_paddle_started_ball(pos: Vector2) -> void:
	var ball = spawn_ball(pos)
	ball.update_direction(Vector2(1, -1))
	balls.append(ball)


func _on_moves_zone_body_entered(body: Node2D) -> void:
	if GameManager.paddle_hit_count < GameManager.max_paddle_hit_count:
		return
	
	GameManager.enable_trajectory()
	for ball in balls:
		ball.apply_moves()

func unapply_moves_on_all_balls():
	GameManager.disable_trajectory()
	for ball in balls:
		ball.unapply_moves()
