extends RigidBody2D
class_name Ball

const speed: float = 50.0
var speed_multiplier_buff_big_ball = 1.0
var speed_multiplier_buff_fast_ball = 1.0

const buff_speed_big_ball: float = 0.5
const buff_speed_fast_ball: float = 1.5

const safety_impulse: float = 20.0
const safety_direction_y: float = 0.09
const easy_mode_angle_offset: float = 0.5

const bigger_ball_texture: Texture2D = preload("res://assets/art/pixel_art/ball_texture_big.png")
const bigger_ball_radius = 7.0
const smaller_ball_texture: Texture2D = preload("res://assets/art/pixel_art/ball_texture_small.png")
const smaller_ball_radius = 4.0



func _ready() -> void:
	$LastHitTimer.start()

func update_direction(direction: Vector2) -> void:
	var speed_multipliers = speed_multiplier_buff_big_ball * speed_multiplier_buff_fast_ball
	linear_velocity = direction.normalized() * speed * speed_multipliers
	
	if abs(direction.normalized().y) < safety_direction_y:
		_on_last_hit_timer_timeout()

func update_speed() -> void:
	update_direction(linear_velocity)

func _on_body_shape_entered(body_rid: RID, body: Node, body_shape_index: int, local_shape_index: int) -> void:
	if body.is_in_group("brick"):
		$LastHitTimer.start()
		var brick: Brick = body as Brick
		brick.process_on_ball_hit()
	elif body.is_in_group("paddle"):
		$LastHitTimer.start()
		var body_2d: Node2D = body as Node2D
		var new_direction = position - body_2d.position
		if GameManager.is_difficulty_easy:
			new_direction.x *= easy_mode_angle_offset
		update_direction(new_direction)

func _on_last_hit_timer_timeout() -> void:
	apply_impulse(Vector2.DOWN * safety_impulse)
	$ImpulseTimer.start()

func _on_impulse_timer_timeout() -> void:
	update_speed()



func set_to_bigger_ball():
	$Sprite2D.texture = bigger_ball_texture
	var shape: CircleShape2D = $CollisionShape2D.shape as CircleShape2D
	shape.radius = bigger_ball_radius

func set_to_smaller_ball():
	$Sprite2D.texture = smaller_ball_texture
	var shape: CircleShape2D = $CollisionShape2D.shape as CircleShape2D
	shape.radius = smaller_ball_radius



func apply_buff_big_ball():
	set_to_bigger_ball()
	speed_multiplier_buff_big_ball = buff_speed_big_ball
	update_speed()

func unapply_buff_big_ball():
	set_to_smaller_ball()
	speed_multiplier_buff_big_ball = 1.0
	update_speed()
	
	
	
func apply_buff_fast_ball():
	speed_multiplier_buff_fast_ball = buff_speed_fast_ball
	update_speed()
	
func unapply_buff_fast_ball():
	speed_multiplier_buff_fast_ball = 1.0
	update_speed()
