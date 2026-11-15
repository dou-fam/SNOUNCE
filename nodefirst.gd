extends Node2D

@export var board: TileMapLayer
@export var count_sprite: AnimatedSprite2D
@export var ball: CharacterBody2D
@export_file("*.tscn") var next_level: String

var block_scene: PackedScene = preload("res://blocks.tscn")
var level_block_counts: Array[int] = [3,4,3,4,6,5,6,4]
@export var current_level: int = 0
var blocks_remaining: int = 0
var dragging_block: Node2D = null
var occupied_cells: Dictionary = {} 

var board_locked: bool = false

func _ready() -> void:
	load_level(current_level)

func load_level(level_idx: int) -> void:
	# remove previous blocks
	for block in occupied_cells.values():
		block.queue_free()
	occupied_cells.clear()
	blocks_remaining = level_block_counts[level_idx]
	counter_updt()

func counter_updt() -> void:
	count_sprite.frame = clamp(blocks_remaining, 0, 9)

func _on_block_button_button_down() -> void:
	if board_locked:
		return
	if blocks_remaining > 0 and dragging_block == null:
		dragging_block = block_scene.instantiate()
		$lvl.add_child(dragging_block)
		# disable collis
		dragging_block.process_mode = Node.PROCESS_MODE_DISABLED

const CELL_SIZE: float = 64.0
const CELL_OFFSET: Vector2 = Vector2(32.0, 32.0)
func _process(_delta: float) -> void:
	if dragging_block != null:
		var mouse_pos: Vector2 = get_global_mouse_position()
		var cell_coords: Vector2i = Vector2i(floor(mouse_pos / CELL_SIZE))
		dragging_block.global_position = Vector2(cell_coords) * CELL_SIZE + CELL_OFFSET
		
func _input(event: InputEvent) -> void:
	if dragging_block != null and event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			place_block()
			
func place_block() -> void:
	var cell_coords: Vector2i = Vector2i(floor(dragging_block.global_position / CELL_SIZE))
	var inside_grid: bool = (cell_coords.x >= 0 and cell_coords.x < 18 and cell_coords.y >= 1 and cell_coords.y < 10)
	var is_empty: bool = not occupied_cells.has(cell_coords)
	if inside_grid and is_empty:
		occupied_cells[cell_coords] = dragging_block
		dragging_block.process_mode = Node.PROCESS_MODE_INHERIT
		blocks_remaining -= 1
		counter_updt()
	else:
		dragging_block.queue_free()
	
	dragging_block = null
	
func _on_start_button_button_down() -> void:
	if board_locked:
		return
	board_locked = true
	ball.start()
	
func nxt_lvl() -> void:
	if next_level != "":
		var audio_stream_player: AudioStreamPlayer
		audio_stream_player = AudioStreamPlayer.new()
		audio_stream_player.stream = preload("uid://h4x51mumojh5")
		audio_stream_player.stop()
		get_tree().change_scene_to_file(next_level)


func _on_rsrtlvlbutton_button_down() -> void:
	get_tree().reload_current_scene()



func _on_homebutton_button_down() -> void:
	get_tree().change_scene_to_file("res://home.tscn")
