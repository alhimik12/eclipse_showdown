class_name enemy_class extends character_class

@onready var player: character_class = get_tree().get_first_node_in_group("player")
var is_dead = false
var death = preload("res://characters/enemies/enemy_death.tscn")

func _ready():
	super()
	wall_sfx_pitch = 0.7
	scorch_dmg *= 0.7
	water_heal /= 1.5

func die():
	var death_node = death.instantiate()
	death_node.global_position = global_position
	get_tree().current_scene.add_child(death_node)
	if not is_dead:
		get_parent().get_node("enemy_spawner").enemy_died(self)
		is_dead = true
		super()
