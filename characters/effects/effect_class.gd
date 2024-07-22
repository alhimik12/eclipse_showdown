class_name effect_class extends Node2D

var character: character_class
var timer: Timer
var is_cleared = true
@export var duration: float
@export var effect_name: String

func _ready():
	timer = Timer.new()
	timer.wait_time = duration
	timer.timeout.connect(timer_timeout)
	add_child(timer)
	timer.start()
	character.effect_manager.has_effect[effect_name] = true
	effect_start()

func extend():
	timer.start()

func timer_timeout():
	is_cleared = false
	clear_effect()

func clear_effect():
	effect_end()
	character.effect_manager.has_effect[effect_name] = false
	queue_free()
	

func effect_end():
	pass

func effect_start():
	pass
