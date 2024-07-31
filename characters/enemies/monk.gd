extends enemy_class

var duration = 0.2
var bomb_sc = preload("res://characters/enemies/projectiles/bomb.tscn")
var dart_sc = preload("res://characters/enemies/projectiles/enemy_dart.tscn")

func process(delta):
	var player_vec = global_position - player.global_position
	if player_vec.length() > 200:
		pass
	elif $dash_cooldown.is_stopped():
		var new_position = global_position + player_vec.normalized() * 200
		var tween = create_tween()
		tween.set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUART)
		#tween.finished.connect(die)
		tween.tween_property(self, "global_position", new_position, duration)
		$dash_cooldown.start()
		spawn_bomb()
		
		$dash_sound.play()

func attack(delta):
	if $dart_timer.is_stopped():
		var dart = dart_sc.instantiate()
		dart.character = self
		dart.element = randi_range(0, 5)
		get_tree().current_scene.add_child(dart)
		$dart_timer.start()
		
		$shoot_sound.play()


func spawn_bomb():
	var bomb = bomb_sc.instantiate()
	bomb.global_position = global_position
	get_tree().current_scene.add_child(bomb)
