extends Control

var menu_type = 0

func start_pressed():
	Sfx.play("click.mp3")
	$main_menu.hide()
	$loadout_chooser.show()
	menu_type = 1

func _process(delta):
	if Input.is_action_just_pressed("escape"):
		Sfx.play("click.mp3", 0.7)
		menu_type = 0
		$loadout_chooser.hide()
		$settings.hide()
		
		$main_menu.show()


func _on_tutorial_pressed():
	Sfx.play("click.mp3")
	get_tree().change_scene_to_file("res://levels/tutorial.tscn")


func _on_settings_pressed():
	Sfx.play("click.mp3")
	$main_menu.hide()
	$settings.show()
	menu_type = 2
