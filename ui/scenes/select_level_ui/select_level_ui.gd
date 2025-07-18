extends Control

signal back_pressed
signal play_pressed
signal previous_pressed
signal next_pressed

func _on_back_pressed() -> void:
	back_pressed.emit()


func _on_play_pressed() -> void:
	play_pressed.emit()


func _on_previous_pressed() -> void:
	previous_pressed.emit()

func _on_next_pressed() -> void:
	next_pressed.emit()

func set_level_number_text(number: int) -> void:
	$LevelNumber.text = "Level " + str(number)
