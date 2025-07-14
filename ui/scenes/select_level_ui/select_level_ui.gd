extends Control

signal back_pressed
signal play_pressed

func _on_back_pressed() -> void:
	back_pressed.emit()


func _on_play_pressed() -> void:
	play_pressed.emit()
