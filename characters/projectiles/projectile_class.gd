class_name projectile_class extends Node2D

var character: character_class
var element: int
@onready var tilemap = character.tilemap
@onready var area2d: Area2D = get_node("Area2D")
@onready var start_timer: Timer = Timer.new()
@export var start_time = 0.08
var hp = 1
@export var dmg: float = 20

func _ready():
	area2d.monitoring = true
	area2d.area_entered.connect(area_entered)

	start_timer.wait_time = start_time
	start_timer.one_shot = true
	start_timer.timeout.connect(on_start)
	add_child(start_timer)
	start_timer.start()
	ready()

func on_start():
	area2d.monitoring = true

func area_entered(area):
	var target = area.get_parent()
	if target != character:
		hit(target)

func hit(target):
	target.get_damage(dmg)
	get_damage(2)

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
