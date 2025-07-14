extends Control

signal play_pressed
signal shop_pressed
signal settings_pressed
signal quit_pressed

func _on_play_pressed() -> void:
	play_pressed.emit()


func _on_shop_pressed() -> void:
	shop_pressed.emit()


func _on_settings_pressed() -> void:
	settings_pressed.emit()


func _on_quit_pressed() -> void:
	quit_pressed.emit()
