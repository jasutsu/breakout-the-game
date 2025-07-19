extends RigidBody2D
class_name Ball

const speed: float = 90.0
var speed_multiplier_buff_big_ball = 1.0
var speed_multiplier_buff_fast_ball = 1.0
var speed_multiplier_moves = 1.0

const buff_speed_big_ball: float = 0.5
const buff_speed_fast_ball: float = 1.5
const speed_moves: float = 0.1

const safety_impulse: float = 30.0
const safety_direction_y: float = 0.09
const easy_mode_angle_offset: float = 1.0

const bigger_ball_texture: Texture2D = preload("res://assets/art/pixel_art/ball_texture_big.png")
const bigger_ball_radius = 7.0
const smaller_ball_texture: Texture2D = preload("res://assets/art/pixel_art/ball_texture_small.png")
const smaller_ball_radius = 4.0

var paddle: Paddle
var impact_position: Vector2

func _ready() -> void:
	$LastHitTimer.start()
	paddle = get_tree().get_first_node_in_group("paddle")

func _process(delta: float) -> void:
	if GameManager.check_trajectory():
		var shape: CircleShape2D = $CollisionShape2D.shape as CircleShape2D
		impact_position = paddle.get_impact_position(
			position,
			linear_velocity,
			shape.radius
		)
		var impact_direction = paddle.get_impact_direction(
			impact_position,
			easy_mode_angle_offset
		)
		GameManager.draw_trajectory(impact_position, impact_direction)

func update_direction(direction: Vector2) -> void:
	var speed_multipliers = (
		speed_multiplier_buff_big_ball *
		speed_multiplier_buff_fast_ball *
		speed_multiplier_moves
	)
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
		SoundManager.play_sfx(GlobalMappings.SfxType.PADDLE_BALL_HIT)
		$LastHitTimer.start()
		var new_direction = position - paddle.position
		if GameManager.is_difficulty_easy:
			new_direction.x *= easy_mode_angle_offset
		update_direction(new_direction)
		if GameManager.paddle_hit_count < GameManager.max_paddle_hit_count:
			GameManager.increase_paddle_hit_count()
		else:
			GameManager.remove_moves_effect()
	else:
		SoundManager.play_sfx(GlobalMappings.SfxType.BALL_HIT_BOUNDARY)

func _on_last_hit_timer_timeout() -> void:
	apply_impulse(Vector2(1, 1) * safety_impulse)
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
	
	
	
func apply_moves():
	speed_multiplier_moves = speed_moves
	update_speed()
	
func unapply_moves():
	speed_multiplier_moves = 1.0
	update_speed()
