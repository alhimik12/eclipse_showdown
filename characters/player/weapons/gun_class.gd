class_name gun_class extends Node2D

@export_file("*.tscn") var projectile
var element: int
@onready var char = get_parent()
@onready var tilemap = char.tilemap

var load_timer = Timer.new()
@export var reload_time: float = 1

var shoot_timer = Timer.new()
@export var shoot_time: float = 1

func _ready():
	init_timer(load_timer, reload_time)
	init_timer(shoot_timer, shoot_time)

func init_timer(timer, time):
	timer.wait_time = time
	timer.one_shot = true
	add_child(timer)

func shoot(time_modifier):
	if shoot_timer.is_stopped():
		before_shoot()
		var proj_node = load(projectile).instantiate()
		proj_node.character = char
		proj_node.element = element
		get_parent().get_parent().add_child(proj_node)
		after_shoot()
		shoot_timer.start(time_modifier * shoot_time)

func loadup_call():
	if load_timer.is_stopped():
		if loadup():
			load_timer.start()

func loadup():
	pass

func before_shoot():
	pass

func after_shoot():
	pass

func ammo_loadup():
	if element == -1:
		default_loadup()

func default_loadup():
	var cell_type = get_cell()
	if cell_type != -1:
		element = cell_type
		clear_cells(element)
		return true
	return false

func mix_loadup():
	var cell_type = get_cell()
	if cell_type != -1:
		element = tilemap.alchemy.combine_elements(element, cell_type)
		clear_cells(cell_type)
		return true
	return false

func clear_cells(elem):
	tilemap.clear_circle(global_position, 2.5, elem)

func get_cell():
	if char.get_node("effect_manager").has_effect["stun"]:
		return 2
	else:
		return tilemap.get_cell_type(global_position)
