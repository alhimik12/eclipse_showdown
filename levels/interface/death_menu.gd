extends Control

func _ready():
	$game_over.process_mode = 3
	$game_over.play()
	get_tree().paused = true
	process_mode = 3
	$VBoxContainer/WAVE.text = "WAVE: " + str(LevelVariables.wave)



func _on_restart_pressed():
	get_tree().paused = false
	LevelVariables.wave = 1
	get_tree().change_scene_to_file("res://levels/" + get_tree().current_scene.name + ".tscn")


func _on_exit_pressed():
	get_tree().paused = false
	LevelVariables.wave = 1
	get_tree().change_scene_to_file("res://levels/interface/menu.tscn")

