extends Node
class_name BuffManager

var bubble_scene = preload("res://scenes/bubble/bubble.tscn")

signal buff_started(bubble_data: BubbleData)
signal buff_finished(bubble_data: BubbleData)

var timers: Dictionary[BubbleData, SceneTreeTimer] = {}

func _ready() -> void:
	spawn_bubble(preload("res://scenes/bubble/bubble_types/bubble_big_ball.tres"), $"../Node2D".position)

func spawn_bubble(bubble_data: BubbleData, pos: Vector2) -> void:
	var bubble = bubble_scene.instantiate()
	bubble.bubble_data = bubble_data
	bubble.position = pos
	add_child(bubble)
	bubble.instantiate()

func start_buff(bubble_data: BubbleData) -> void:
	if timers.has(bubble_data):
		var time_left: float = timers[bubble_data].time_left
		timers[bubble_data].wait_time = time_left + bubble_data.duration
		return
		
	buff_started.emit(bubble_data)
	var timer: SceneTreeTimer = get_tree().create_timer(bubble_data.duration)
	timer.timeout.connect(finish_buff.bind(bubble_data))
	timers[bubble_data] = timer

func finish_buff(bubble_data: BubbleData) -> void:
	timers.erase(bubble_data)
	buff_finished.emit(bubble_data)
