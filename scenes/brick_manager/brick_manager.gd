extends Node

signal game_win

func _ready() -> void:
	game_win.connect(GameManager.set_time_scale_to_zero)
	game_win.connect(UiManager.on_game_win)
	game_win.connect(SoundManager.play_sfx.bind(GlobalMappings.SfxType.GAME_WIN))

func check_game_win() -> void:
	var count: int = 0
	for child in get_children():
		var brick_tile_map: BrickTileMap = child as BrickTileMap
		print(brick_tile_map.name)
		print(brick_tile_map.brick_count)
		count += brick_tile_map.brick_count
	if count <= 0:
		game_win.emit()
