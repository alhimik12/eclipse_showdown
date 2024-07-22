extends Node2D

@export var hp_bar: Node2D

@export var hp_max: float = 100
var hp = hp_max

func _ready():
	hp_bar.progress_max = hp_max
	hp_bar.progress = hp

func get_damage(dmg):
	hp -= dmg
	if hp <= 0:
		pass #do die stuff
	if hp > hp_max:
		hp = hp_max
	hp_bar.update(hp)
