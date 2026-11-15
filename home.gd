extends Node2D

func _on_texture_button_2_button_down() -> void:
	get_tree().quit()


func _on_texture_button_button_down() -> void:
	get_tree().change_scene_to_file("res://nodefirst.tscn")



func _on_texture_button_3_button_down() -> void:
	get_tree().change_scene_to_file("res://lvl_select.tscn")


func _on_texture_button_5_pressed() -> void:
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
