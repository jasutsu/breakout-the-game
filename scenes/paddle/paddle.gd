extends CharacterBody2D

@export var default_input_speed := 6000
@export var mouse_input_speed := 300
@export var mouse_input_threshold := 2.0
@export var is_difficulty_easy = true

var horizontal_velocity: float = 0.0

signal started_ball(pos: Vector2)

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _physics_process(delta: float) -> void:
	velocity = Vector2.RIGHT * horizontal_velocity * delta
	move_and_slide()

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("start_ball"):
		if $BallSpawnPosition.visible:
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
		if is_difficulty_easy:
			horizontal_velocity = mouse_horizontal_delta * mouse_input_speed
		else:
			var horizontal_dir = 1 if mouse_horizontal_delta > 0 else -1
			horizontal_velocity = horizontal_dir * default_input_speed
