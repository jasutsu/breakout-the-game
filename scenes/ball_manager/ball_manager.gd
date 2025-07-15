extends Node

var ball_scene = preload("res://scenes/ball/ball.tscn")
var balls: Array[Ball] = []

func _on_buff_manager_buff_started(bubble_data: BubbleData) -> void:
	if bubble_data.name == "big_ball":
		pass
	elif bubble_data.name == "fast_ball":
		pass
	elif bubble_data.name == "split_ball":
		var new_balls: Array[Ball] = []
		for ball in balls:
			var direction := ball.linear_velocity.normalized()
			var speed := ball.linear_velocity.length()
			var ball1 = spawn_ball(ball.position)
			ball1.linear_velocity = direction.rotated(-PI/4) * speed
			var ball2 = spawn_ball(ball.position)
			ball2.linear_velocity = direction.rotated(PI/4) * speed
			new_balls.append_array([ball1, ball2])
			ball.queue_free()
		balls.clear()
		balls = new_balls

func _on_buff_manager_buff_finished(bubble_data: BubbleData) -> void:
	if bubble_data.name == "big_ball":
		pass
	elif bubble_data.name == "fast_ball":
		pass
	elif bubble_data.name == "split_ball":
		pass

func spawn_ball(position: Vector2) -> Ball:
	var ball: Ball = ball_scene.instantiate()
	add_child(ball)
	ball.position = position
	ball.linear_velocity = Vector2(1, -1) * 120.0
	return ball
#
#
#func expand_balls():
	#for ball in balls:
		#ball.update_ball_data(ball_type_large)
		#ball.update_speed(ball.speed)
	#
#func shrink_balls():
	#for ball in balls:
		#ball.update_ball_data(ball_type_normal)
		#ball.update_speed(ball.speed)

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
		print("Game Over!")


func _on_paddle_started_ball(pos: Vector2) -> void:
	var ball = spawn_ball(pos)
	balls.append(ball)
