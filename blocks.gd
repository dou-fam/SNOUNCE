extends StaticBody2D

func _input_event(_viewport: Viewport, event: InputEvent, _shape_idx: int) -> void:
	if get_tree().current_scene.board_locked:
		return
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		rotation += deg_to_rad(90)
	
