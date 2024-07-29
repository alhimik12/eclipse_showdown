extends enemy_class

var speed = 200

func _ready():
	super()
	knockback_power = 25
	break_radius = 2

func wall_hit():
	super()
	$dash.cancel()

func process(delta):
	global_position = global_position.move_toward(player.global_position, get_speed(speed) * delta)
	if effect_manager.has_effect["stun"]:
		can_attack = false
	if effect_manager.has_effect["burn"]:
		speed_change = 1.8

func attack(delta):
	$dash.use()
	$knife_throw.use()
