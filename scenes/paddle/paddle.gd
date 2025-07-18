extends CharacterBody2D
class_name Paddle

@export var default_input_speed := 6000
@export var mouse_input_speed := 500
@export var mouse_input_threshold := 2.0

var speed_multiplier: float = 1.0
const buff_speed_paddle_fast: float = 1.5

const buff_paddle_one_height: float = 32.0
const buff_paddle_three_height: float = 96.0

var horizontal_velocity: float = 0.0

signal started_ball(pos: Vector2)

func _physics_process(delta: float) -> void:
	velocity = Vector2.RIGHT * horizontal_velocity * speed_multiplier * delta
	move_and_slide()

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("start_ball"):
		var is_in_game: bool = (
			UiManager.get_ui_current_state_name() == 
			GlobalMappings.IN_GAME_STATE_NAME
		)
		if $BallSpawnPosition.visible and is_in_game:
			started_ball.emit($BallSpawnPosition.global_position)
			$BallSpawnPosition.visible = false
	
	horizontal_velocity = 0
	if event is InputEventKey:
		var horizontal_dir = 0
		if Input.is_action_pressed("ui_right"):
			horizontal_dir = 1
		if Input.is_action_pressed("ui_left"):
			horizontal_dir = -1
		horizontal_velocity = horizontal_dir * default_input_speed
	elif event is InputEventMouseMotion:
		var mouse_horizontal_delta = event.relative.x
		if abs(mouse_horizontal_delta) < mouse_input_threshold:
			return
		if GameManager.is_difficulty_easy:
			horizontal_velocity = mouse_horizontal_delta * mouse_input_speed
		else:
			var horizontal_dir = 1 if mouse_horizontal_delta > 0 else -1
			horizontal_velocity = horizontal_dir * default_input_speed


func _on_buff_manager_buff_started(buff_type: GlobalMappings.BuffType) -> void:
	if buff_type == GlobalMappings.BuffType.PADDLE_FAST:
		speed_multiplier = buff_speed_paddle_fast
	elif buff_type == GlobalMappings.BuffType.PADDLE_TWO:
		$paddle_two.visible = true
		change_collision_height(buff_paddle_three_height)

func _on_buff_manager_buff_finished(buff_type: GlobalMappings.BuffType) -> void:
	if buff_type == GlobalMappings.BuffType.PADDLE_FAST:
		speed_multiplier = 1.0
	if buff_type == GlobalMappings.BuffType.PADDLE_TWO:
		$paddle_two.visible = false
		change_collision_height(buff_paddle_one_height)

func change_collision_height(height: float) -> void:
	var shape: CapsuleShape2D = $CollisionShape2D.shape as CapsuleShape2D
	shape.height = height
	

func get_impact_position(ball_pos: Vector2, ball_dir: Vector2, ball_radius: float) -> Vector2:
	var shape: CapsuleShape2D = $CollisionShape2D.shape as CapsuleShape2D
	var top_y: float = position.y - shape.radius
	var x_offset: float = (ball_dir.x / abs(ball_dir.y)) * abs(ball_pos.y - top_y)
	print(ball_pos.x - x_offset)
	return Vector2(ball_pos.x - x_offset, top_y - ball_radius)

func get_impact_direction(impact_pos: Vector2, easy_offset: float) -> Vector2:
	var direction := impact_pos - position
	if GameManager.is_difficulty_easy:
		direction.x *= easy_offset
	return direction
