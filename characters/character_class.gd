class_name character_class extends Node2D

@export var tilemap: Node2D
@onready var effect_manager = get_node("effect_manager")

var is_burning = false
var speed_change = 1
var knockback_power = 15
var speed_multiplyer = 1
var reload_change = 1
var can_attack = true
var previous_position = Vector2.ZERO

func wall_hit():
	global_position -= tilemap.get_cell_direction(global_position) * knockback_power
	tilemap.clear_circle(global_position, 3, 2)

func knockback(direction, power):
	global_position += direction * power

func move_damage(dmg, delta):
	var position_change = (global_position-previous_position).length()
	get_damage(dmg * delta * (position_change)**2)

func _process(delta):
	speed_change = 1
	reload_change = 1
	can_attack = true
	
	var cell_type = tilemap.get_cell_type(global_position)
	match cell_type:
		0:
			speed_change = 0.4
			get_damage(-10 * delta)
			effect_manager.clear_effects()
		1:
			speed_change = 1.8
			effect_manager.apply_effect("burn")
		2:
			wall_hit()
			effect_manager.apply_effect("stun")
		3:
			move_damage(0.8, delta)
			get_damage(3 * delta)
			reload_change = 0.3
		4:
			can_attack = false
		5:
			get_damage(60 * delta)
		
	
	previous_position = global_position
	process(delta)

func get_damage(dmg):
	$hp_manager.get_damage(dmg)

func process(delta):
	pass
	
