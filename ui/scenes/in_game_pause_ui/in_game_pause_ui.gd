extends Control

signal action_button_pressed
signal go_to_main_menu_pressed

func _on_action_button_pressed() -> void:
	action_button_pressed.emit()


func _on_go_to_main_menu_pressed() -> void:
	go_to_main_menu_pressed.emit()

func set_action_button_text(text: String) -> void:
	%Action.text = text
