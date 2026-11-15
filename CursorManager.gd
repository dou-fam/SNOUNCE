extends Node
func _ready() -> void:
	Input.set_custom_mouse_cursor(load("res://kenney_cursor-pack/Vector/Basic/hand_open.svg"), Input.CURSOR_POINTING_HAND)
	Input.set_custom_mouse_cursor(load("res://kenney_cursor-pack/Vector/Basic/hand_point.svg"), Input.CURSOR_HSIZE)
