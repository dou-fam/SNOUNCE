extends Sprite2D

var started: bool = false

func start():
	if not started:
		return
	else:
		Sprite2D.hide
