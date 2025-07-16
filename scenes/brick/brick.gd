extends StaticBody2D
class_name Brick

@export var type: GlobalMappings.BrickType
@export var normal_rect: Rect2
@export var cracked_rect: Rect2

var health: int

func _ready() -> void:
	health = GlobalMappings.BrickResources[type].health

func process_on_ball_hit():
	if GlobalMappings.BrickResources[type].wall:
		return
		
	if health == 2:
		health -= 1
		$Sprite2D.region_rect = cracked_rect
	elif health == 1:
		if GlobalMappings.BrickResources[type].has_buff and GlobalMappings.BrickResources[type].buff_type != null:
			GameManager.spawn_bubble(GlobalMappings.BrickResources[type].buff_type, position)
		queue_free()
	
