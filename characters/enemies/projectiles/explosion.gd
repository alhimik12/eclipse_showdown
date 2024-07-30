extends Node2D

var dmg = 40

func _ready():
	$anim.play("new_animation")



func timer_timeout():
	queue_free()


func _on_area_2d_area_entered(area):
	area.get_parent().get_damage(dmg)
