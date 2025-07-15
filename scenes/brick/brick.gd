extends StaticBody2D
class_name Brick

@export var brick_data: BrickData

@export var normal_rect: Rect2
@export var cracked_rect: Rect2

var health: int

var bubble_big_ball = preload("res://scenes/bubble/bubble_types/bubble_big_ball.tres")
var bubble_fast_ball = preload("res://scenes/bubble/bubble_types/bubble_fast_ball.tres")
var bubble_fast_paddle = preload("res://scenes/bubble/bubble_types/bubble_fast_paddle.tres")
var bubble_split_ball = preload("res://scenes/bubble/bubble_types/bubble_split_ball.tres")
var bubble_two_paddles = preload("res://scenes/bubble/bubble_types/bubble_two_paddles.tres")

var bubble_dict: Dictionary[String, BubbleData] = {}

func _ready() -> void:
	health = brick_data.health
	bubble_dict = {
	"big_ball": bubble_big_ball,
	"fast_ball": bubble_fast_ball,
	"fast_paddle": bubble_fast_paddle,
	"split_ball": bubble_split_ball,
	"two_paddle": bubble_two_paddles,
}

func process_on_ball_hit():
	if brick_data.wall:
		return
		
	if health == 2:
		health -= 1
		$Sprite2D.region_rect = cracked_rect
	elif health == 1:
		if brick_data.buff != "none":
			var buff_manager: BuffManager = get_tree().get_first_node_in_group("buff_manager") as BuffManager
			buff_manager.spawn_bubble(bubble_dict[brick_data.buff], position)
		queue_free()
	
