extends CanvasLayer

var opened = false

func _input(event):
	if event is InputEventKey and event.pressed and event.keycode == KEY_ESCAPE:
		if opened:
			opened = false
			close()
		else:
			opened = true
			open()

func open():
	$menu.visible = true
	if get_node_or_null("tutorial_text") != null:
		get_node("tutorial_text").hide()
	get_tree().paused = true
	process_mode = 3

func close():
	$menu.visible = false
	if get_node_or_null("tutorial_text") != null:
		get_node("tutorial_text").show()
	get_tree().paused = false


func _on_return_pressed():
	close()


func _on_exit_pressed():
	get_tree().paused = false
	LevelVariables.wave = 1
	get_tree().change_scene_to_file("res://levels/interface/menu.tscn")
