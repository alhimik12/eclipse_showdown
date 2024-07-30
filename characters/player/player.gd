extends character_class

var base_speed = 450
var direction
@export var gun1: gun_class
@export var gun2: gun_class
var death_menu = preload("res://levels/interface/death_menu.tscn")

func _ready():
	gun1 = $gun_component.create_gun(LevelVariables.gun1, LevelVariables.elem1)
	gun2 = $gun_component.create_gun(LevelVariables.gun2, LevelVariables.elem2)
	

func die():
	var death_menu_node = death_menu.instantiate()
	get_tree().current_scene.get_node("escape_menu").add_child(death_menu_node)

func process(delta):
	direction = Vector2(Input.get_axis("more_left", "move_right"), Input.get_axis("move_up", "move_down")).normalized()
	global_position += direction * get_speed(base_speed) * delta
	
	if Input.is_action_pressed("loadup1"):
		gun1.loadup_call()
	
	if Input.is_action_pressed("loadup2"):
		gun2.loadup_call()

#func attack(delta):
	#if Input.is_action_pressed("attack1"):
		#gun1.shoot(reload_change)
	#if Input.is_action_pressed("attack2"):
		#gun2.shoot(reload_change)

func _unhandled_input(event):
	if event.is_action("attack1") and event.pressed and can_attack:
		gun1.shoot(reload_change)
	if event.is_action("attack2") and event.pressed and can_attack:
		gun2.shoot(reload_change)
