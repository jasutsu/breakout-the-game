extends Node

const BackgroundMusicNames = {
	PEACEFUL = "Peaceful",
	MOOD = "Mood",
}

const SfxNames = {
	HOVER_BUTTON = "HoverButton",
	CLICK_BUTTON = "ClickButton",
}

var bg_music_map: Dictionary[String, AudioStreamPlayer] = {}
var sfx_map: Dictionary[String, AudioStreamPlayer] = {}

func _ready() -> void:
	for child in $BackgroundMusic.get_children():
		bg_music_map[child.name] = child
		
	for child in $Sfx.get_children():
		sfx_map[child.name] = child
	
	#bg_music_map[BackgroundMusicNames.MOOD].play()

func play_sfx(sound_name: String) -> void:
	if sfx_map.has(sound_name):
		sfx_map[sound_name].play()

func play_bg_music(sound_name: String) -> void:
	if not bg_music_map.has(sound_name):
		return
		
	for key in bg_music_map.keys():
		bg_music_map[key].stop()
		
	bg_music_map[sound_name].play()
