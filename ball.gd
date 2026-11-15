extends CharacterBody2D

const CELL_SIZE: float = 64
const CELL_OFFSET: Vector2 = Vector2(32, 32) # Center of each 64x64 grid square

var started: bool = false

var speed := 250
var directions := [
	Vector2.RIGHT,
	Vector2.DOWN,
	Vector2.LEFT,
	Vector2.UP
]

func _ready():
	velocity = Vector2.DOWN * speed
	
func start() -> void:
	$arrow.visible = false
	global_position = get_cell_center(global_position)
	started = true
	
func _physics_process(delta):
	if not started:
		return

	var target_center := get_cell_center(global_position)
	if abs(velocity.x) > abs(velocity.y):
		global_position.y = move_toward(global_position.y, target_center.y, 15.0)
	elif abs(velocity.y) > abs(velocity.x):
		global_position.x = move_toward(global_position.x, target_center.x, 15.0)

	var collision = move_and_collide(velocity * delta)

	if collision :
		var collider = collision.get_collider()
		if collider.name != "end":
			
			var reflected = velocity.bounce(collision.get_normal()).normalized()
			var best_direction = directions[0]
			for direction in directions:
				if reflected.dot(direction) > reflected.dot(best_direction):
					best_direction = direction
			if collider != null and collider.name != "walls" and collider.name != "obstacle" and collider.name != "end":
				var speed := 125
				# snap to space next to block
				global_position = get_cell_center(collider.global_position) + (best_direction * CELL_SIZE)
			else:
				global_position = get_cell_center(global_position)

			velocity = best_direction * speed
			var speed := 250
		
		if collision and collider.name == "end":
			global_position = get_cell_center(collider.global_position)
			get_tree().current_scene.nxt_lvl()
			
		if collision and collider.name == "walls":
			get_tree().reload_current_scene()
		
func get_cell_center(pos: Vector2) -> Vector2:
	var cell := Vector2(floor(pos / CELL_SIZE))
	return cell * CELL_SIZE + CELL_OFFSET
