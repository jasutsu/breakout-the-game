extends StaticBody2D
class_name Brick

@export var type: GlobalMappings.BrickType
@export var first_cracked_rect: Rect2
@export var second_cracked_rect: Rect2

var health: int

func _ready() -> void:
	health = GlobalMappings.BrickResources[type].health
	
	var colors_size = GlobalMappings.BrickColorResource.bricks_colors.colors.size()
	$Sprite2D.modulate = GlobalMappings.BrickColorResource.bricks_colors.colors[randi() % colors_size]
	
	if GlobalMappings.BrickResources[type].wall:
		$Sprite2D.modulate = GlobalMappings.BrickColorResource.brick_wall_color
	
	if GlobalMappings.BrickResources[type].has_buff:
		$BuffOutline.visible = true
		$BuffOutline.modulate = GlobalMappings.BrickColorResource.brick_outline_color
	
	
	if not GlobalMappings.BrickResources[type].wall:
		var brick_tile_map: BrickTileMap = get_parent() as BrickTileMap
		brick_tile_map.increase_brick_count()

func process_on_ball_hit():
	if GlobalMappings.BrickResources[type].wall:
		SoundManager.play_sfx(GlobalMappings.SfxType.BRICK_WALL)
		return
		
	if health == 3:
		health -= 1
		$Sprite2D.region_rect = first_cracked_rect
		SoundManager.play_sfx(GlobalMappings.SfxType.BRICK_CRACKED)
	elif health == 2:
		health -= 1
		$Sprite2D.region_rect = second_cracked_rect
		SoundManager.play_sfx(GlobalMappings.SfxType.BRICK_CRACKED)
	elif health == 1:
		if GlobalMappings.BrickResources[type].has_buff and GlobalMappings.BrickResources[type].buff_type != null:
			GameManager.spawn_bubble(GlobalMappings.BrickResources[type].buff_type, position)
			SoundManager.play_sfx(GlobalMappings.SfxType.BRICK_BUFF)
		else:
			SoundManager.play_sfx(GlobalMappings.SfxType.BRICK_SMASHED)
			
		var tile_map_layer: BrickTileMap = get_parent() as BrickTileMap
		var tile_map_pos = tile_map_layer.local_to_map(position)
		tile_map_layer.decrease_brick_count()
		tile_map_layer.erase_cell(tile_map_pos)
