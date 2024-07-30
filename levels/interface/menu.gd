extends Control

var menu_type = 0

func start_pressed():
	$main_menu.hide()
	$loadout_chooser.show()
	menu_type = 1

func _process(delta):
	if Input.is_action_just_pressed("escape"):
		menu_type = 0
		$loadout_chooser.hide()
		
		$main_menu.show()


func _on_tutorial_pressed():
	get_tree().change_scene_to_file("res://levels/tutorial.tscn")
