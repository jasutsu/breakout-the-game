extends Node2D
class_name Controller

@export var speed := 100

var world_object_position: Vector2

func initialize() -> void:
	$StateMachine.initialize()

func set_world_object_position(pos: Vector2):
	world_object_position = pos

func some_function():
	pass
	
func some_condition():
	pass
	
func cleanup():
	pass
	
