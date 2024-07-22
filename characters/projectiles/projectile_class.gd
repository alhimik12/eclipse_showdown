class_name projectile_class extends Node2D

var character: character_class
var element: int
@onready var tilemap = character.tilemap
var hp = 1

func _ready():
	modulate = character.tilemap.alchemy.element_colors[element]
	ready()

func ready():
	pass

func _process(delta):
	check_collision()
	process(delta)

func check_collision():
	var cell_type = tilemap.get_cell_type(global_position)
	if cell_type == 2:
		tilemap.clear_circle(global_position, 3, 2)
		get_damage(1)

func get_damage(dmg):
	hp -= dmg
	if hp <= 0:
		die()


func die():
	on_death()
	queue_free()

func on_death():
	pass

func process(delta):
	pass
