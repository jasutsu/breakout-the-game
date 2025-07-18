extends TileMapLayer
class_name BrickTileMap

var brick_count: int

signal brick_count_reduced

func increase_brick_count() -> void:
	brick_count += 1

func decrease_brick_count() -> void:
	brick_count -= 1
	brick_count_reduced.emit()
