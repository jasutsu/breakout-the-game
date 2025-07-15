extends RigidBody2D
class_name Ball


func _on_body_shape_entered(body_rid: RID, body: Node, body_shape_index: int, local_shape_index: int) -> void:
	if body.is_in_group("brick"):
		#var tile_map_layer: TileMapLayer = body as TileMapLayer
		#var cell_map_position = tile_map_layer.get_coords_for_body_rid(body_rid)
		#var cell_atlas_position = tile_map_layer.get_cell_atlas_coords(cell_map_position)
		#if cell_atlas_position == Vector2i(14, 0):
			#tile_map_layer.set_cell(cell_map_position, 0, Vector2i(15, 0))
		#elif cell_atlas_position == Vector2i(15, 0):
			#tile_map_layer.erase_cell(cell_map_position)
		pass
	elif body.is_in_group("paddle"):
		var body_2d: Node2D = body as Node2D
		var new_direction = position - body_2d.position
		linear_velocity = new_direction.normalized() * linear_velocity.length()
