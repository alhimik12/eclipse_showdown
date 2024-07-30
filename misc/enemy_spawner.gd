extends Node2D

var biggest_cost
var lowest_cost
var wave_count = 1
var cost
var enemy_costs = {bug = 4, slime = 5, bull = 10, monk = 7}
var enemy_scenes = {\
 bug = preload("res://characters/enemies/bug.tscn"),\
 slime = preload("res://characters/enemies/slime.tscn"),\
 bull = preload("res://characters/enemies/bull.tscn"),\
 monk = preload("res://characters/enemies/monk.tscn")}
var enemy_names = []
var enemy_amount

func _ready():
	biggest_cost = 10
	lowest_cost = 4
	enemy_names = enemy_costs.keys()
	enemy_amount = len(enemy_names)
	spawn_wave()

func get_wave_cost(wave):
	return 8 + wave * 2

func enemy_died():
	if len(get_tree().get_nodes_in_group("enemy")) == 1:
		spawn_wave()

func spawn_wave():
	cost = get_wave_cost(wave_count)
	if randf_range(1, 10) <= 7:
		spawn_enemy("slime")
	while cost >= biggest_cost:
		spawn_enemy(enemy_names[randi_range(0, enemy_amount-1)])
	while cost >= lowest_cost:
		for i in enemy_names:
			if enemy_costs[i] <= cost:
				spawn_enemy(i)
	if cost > 0:
		spawn_enemy("bug")
	cost = 0
	wave_count += 1
	LevelVariables.wave = wave_count
	
func random_circle(center, radius):
	return Vector2.RIGHT.rotated(randf_range(-PI, PI)) * randf_range(0, radius**2)**0.5 + center

func spawn_enemy(enemy):
	cost -= enemy_costs[enemy]
	var enemy_node = enemy_scenes[enemy].instantiate()
	enemy_node.global_position = random_circle(Vector2.ZERO, 700)
	get_tree().current_scene.add_child.call_deferred(enemy_node)
