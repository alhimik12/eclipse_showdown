extends Node2D

func create_gun(gun_type, elem):
	var gun = load("res://characters/player/weapons/" + gun_type + ".tscn").instantiate()
	get_parent().add_child(gun)
	gun.init()
	gun.element = elem
	return gun
