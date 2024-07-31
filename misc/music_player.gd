extends Node2D

var music = ["angry_robot", "white_space"]

func _ready():
	random_play()

func random_play():
	play(music[randi_range(0, len(music)-1)])

func play(path):
	var player: AudioStreamPlayer = AudioStreamPlayer.new()
	player.stream = load('res://audio/music/' + path + ".mp3")
	add_child(player)
	player.finished.connect(finished)
	player.play()

func finished():
	random_play()
