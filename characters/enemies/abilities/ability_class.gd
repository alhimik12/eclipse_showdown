class_name ability_class extends Node2D

@onready var enemy: enemy_class = get_parent()
@onready var player = get_tree().get_first_node_in_group("player")
@export var cooldown: float
var timer: Timer

func _ready():
	timer = Timer.new()
	timer.wait_time = cooldown
	timer.one_shot = true
	add_child(timer)
	timer.start()

func use() -> bool:
	if timer.is_stopped():
		activate()
		timer.start(cooldown * enemy.reload_change)
		return true
	return false

func dist_to_player():
	return (enemy.global_position-player.global_position).length()

func activate():
	pass
