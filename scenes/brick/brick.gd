extends StaticBody2D
class_name Brick

@export var type: GlobalMappings.BrickType
@export var first_cracked_rect: Rect2
@export var second_cracked_rect: Rect2

var health: int

func _ready() -> void:
	health = GlobalMappings.BrickResources[type].health
	
	var colors_size = GlobalMappings.BrickColors.colors.size()
	$Sprite2D.modulate = GlobalMappings.BrickColors.colors[randi() % colors_size]

func process_on_ball_hit():
	if GlobalMappings.BrickResources[type].wall:
		return
		
	if health == 3:
		health -= 1
		$Sprite2D.region_rect = first_cracked_rect
	elif health == 2:
		health -= 1
		$Sprite2D.region_rect = second_cracked_rect
	elif health == 1:
		if GlobalMappings.BrickResources[type].has_buff and GlobalMappings.BrickResources[type].buff_type != null:
			GameManager.spawn_bubble(GlobalMappings.BrickResources[type].buff_type, position)
		queue_free()
	
