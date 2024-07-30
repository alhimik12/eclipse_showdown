class_name character_class extends Node2D

@onready var tilemap: tile_map_class = get_tree().get_first_node_in_group("tilemap")
@onready var effect_manager = get_node("effect_manager")

var is_burning = false
var speed_change = 1
var knockback_power = 15
var speed_multiplyer = 1
var reload_change = 1
var not_frozen = true
var can_attack = true
var previous_position = Vector2.ZERO
var break_radius = 2.75

var water_speed = 0.4
var water_heal = 15
var fire_speed = 1.8
var light_reload = 0.3
var light_dmg = 0.55
var scorch_dmg = 45

func die():
	queue_free()

func _ready():
	ready()

func ready():
	pass

func wall_hit():
	knockback(-tilemap.get_cell_direction(global_position), knockback_power)
	tilemap.clear_circle(global_position, break_radius, 2)

func knockback(direction, power):
	var tween = create_tween()
	tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CIRC)
	tween.tween_property(self, "global_position", global_position + direction * power, 0.2)

func move_damage(dmg, delta):
	var position_change = (global_position-previous_position).length()
	get_damage(dmg * delta * (position_change)**2)

func get_speed(spd):
	return spd * speed_change * speed_multiplyer
	

func _process(delta):
	can_attack = true
	
	if not not_frozen:
		can_attack = false
	
	var cell_type = tilemap.get_cell_type(global_position)
	var sun = tilemap.get_node("sun")
	if global_position.distance_to(sun.center) > (sun.radius + sun.width) * 18:
		cell_type = 5
	match cell_type:
		0:
			speed_change = water_speed
			get_damage(-water_heal * delta)
			effect_manager.clear_effects()
		1:
			speed_change = fire_speed
			effect_manager.apply_effect("burn")
		2:
			wall_hit()
			effect_manager.apply_effect("stun")
		3:
			move_damage(light_dmg, delta)
			reload_change = light_reload
		4:
			can_attack = false
		5:
			get_damage(scorch_dmg * delta)
		
	
	previous_position = global_position
	process(delta)
	if can_attack:
		attack(delta)
	speed_change = 1
	reload_change = 1

func attack(delta):
	pass

func get_damage(dmg):
	$hp_manager.get_damage(dmg)

func process(delta):
	pass
	
