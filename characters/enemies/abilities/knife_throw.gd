extends ability_class

var knife_sc = preload("res://characters/enemies/projectiles/knife.tscn")
var distance = 160
var distance_mult = 1
var duration = 0.3
var delay = 0.2
var knife

func activate():
	knife = knife_sc.instantiate()
	knife.character = get_parent()
	var speed_mult = enemy.get_speed(1)
	if enemy.effect_manager.has_effect["burn"]:
		knife.modulate = Color.INDIAN_RED
	else:
		knife.modulate = Color.DARK_GRAY
	knife.distance = enemy.get_speed(distance) 
	knife.duration = duration
	get_parent().get_parent().add_child(knife)
	$Timer.start(delay)

func use() -> bool:
	if dist_to_player() <= distance * 1.5:
		return super()
	return false

func timer_timeout():
	if knife != null:
		knife.init()
