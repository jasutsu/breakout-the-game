extends Node

var sfx_scene = preload("res://more_autoloads/sound_manager/sfx.tscn")

func _ready() -> void:
	play_bg_music()

func play_sfx(type: GlobalMappings.SfxType) -> void:
	var sfx_player: AudioStreamPlayer = sfx_scene.instantiate() as AudioStreamPlayer
	sfx_player.initialize(type)
	sfx_player.finished.connect(delete_sfx.bind(sfx_player))
	add_child(sfx_player)

func play_bg_music() -> void:
	$Music.stream = GlobalMappings.MusicResource
	$Music.play()

func delete_sfx(sfx_player: AudioStreamPlayer):
	sfx_player.queue_free()
