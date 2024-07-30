extends Node2D

var explosion_sc = preload("res://characters/enemies/projectiles/explosion.tscn")

func activate(a):
	if $timer.is_stopped():
		$anim.play("blink")
		$timer.start()


func timer_timeout():
	explode()

func explode():
	var explosion = explosion_sc.instantiate()
	explosion.global_position = global_position
	get_tree().current_scene.add_child(explosion)
	queue_free()
