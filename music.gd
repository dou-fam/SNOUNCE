extends Node
var audio_stream_player: AudioStreamPlayer

func _ready() -> void:
	audio_stream_player = AudioStreamPlayer.new()
	add_child(audio_stream_player)
	bgm_play()

func bgm_play() -> void:
	audio_stream_player.stream = preload("uid://h4x51mumojh5")
	audio_stream_player.play()
