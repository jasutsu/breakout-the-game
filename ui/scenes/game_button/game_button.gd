extends Button

signal button_clicked

func _on_pressed() -> void:
	SoundManager.play_sfx(GlobalMappings.SfxType.BUTTON_CLICK)
	button_clicked.emit()

func _on_mouse_entered() -> void:
	SoundManager.play_sfx(GlobalMappings.SfxType.BUTTON_HOVER)
