extends Node

const MAX_POLYPHONY_MAP = {
	# ...
}

var _players := {}

func play(path: String, pitch: float = 1, volume: float = 0) -> void:
	var player := _players.get([path, pitch, volume]) as AudioStreamPlayer
	if player:
		player.play()
		return
	
	
	player = AudioStreamPlayer.new()
	player.bus = &'SFX'
	player.stream = load('res://audio/' + path)
	player.pitch_scale = pitch
	player.volume_db = volume
	#player.max_polyphony = MAX_POLYPHONY_MAP.get(path, 1)
	add_child(player)
	_players[[path, pitch, volume]] = player
	player.play()
