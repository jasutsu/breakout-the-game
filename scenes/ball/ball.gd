extends RigidBody2D
class_name Ball

const speed: float = 120.0
const safety_impulse: float = 20.0
var is_hit = false
const easy_mode_angle_offset: float = 0.5
#func update_linear_velocity(direction: Vector2, speed: float) -> void:
	#linear_velocity = direction * speed

#func update_speed(speed_value: float) -> void:
	#speed = speed_value
	#linear_velocity = linear_velocity.normalized() * speed_value

func update_direction(direction: Vector2) -> void:
	linear_velocity = direction.normalized() * speed

func _on_body_shape_entered(body_rid: RID, body: Node, body_shape_index: int, local_shape_index: int) -> void:
	$LastHitTimer.start()
	if body.is_in_group("brick"):
		var brick: Brick = body as Brick
		brick.process_on_ball_hit()
	elif body.is_in_group("paddle"):
		var body_2d: Node2D = body as Node2D
		var new_direction = position - body_2d.position
		if GameManager.is_difficulty_easy:
			new_direction.x *= easy_mode_angle_offset
		update_direction(new_direction)

func _on_last_hit_timer_timeout() -> void:
	apply_impulse(Vector2.DOWN * safety_impulse)
	$ImpulseTimer.start()

func _on_impulse_timer_timeout() -> void:
	update_direction(linear_velocity.normalized())
