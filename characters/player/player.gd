extends character_class

var base_speed = 450
@export var gun1: gun_class
@export var gun2: gun_class


func _ready():
	effect_manager.apply_effect("slow")

func process(delta):
	var direction = Vector2(Input.get_axis("more_left", "move_right"), Input.get_axis("move_up", "move_down")).normalized()
	global_position += direction * base_speed * speed_change * delta * speed_multiplyer
	
	
	if can_attack:
		if Input.is_action_pressed("attack1"):
			gun1.shoot(reload_change)
		if Input.is_action_pressed("attack2"):
			gun2.shoot(reload_change)
		
	
	if Input.is_action_pressed("loadup1"):
		gun1.loadup_call()
		
	if Input.is_action_pressed("loadup2"):
		gun2.loadup_call()
