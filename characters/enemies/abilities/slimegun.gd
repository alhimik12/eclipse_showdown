extends ability_class

var slimeball_sc = preload("res://characters/enemies/projectiles/slime_ball.tscn")

func activate():
	var slimeball = slimeball_sc.instantiate()
	slimeball.character = enemy
	get_tree().current_scene.add_child(slimeball)
