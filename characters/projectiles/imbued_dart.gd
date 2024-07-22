extends projectile_class

var direction
var speed = 1500

func ready():
	hp = 2
	global_position = character.global_position
	look_at(get_global_mouse_position())
	direction = Vector2.RIGHT.rotated(rotation)

func process(delta):
	global_position += direction * speed * delta

func on_death():
	character.effect_manager.apply_effect(get_element())

func get_element():
	match element:
		0:
			return "slow"
		1:
			return "burn"
		2:
			return "stun"
		3:
			return "blind"
		4:
			return "frozen"
		5:
			return "execution"


func lifetime_timeout():
	die()
