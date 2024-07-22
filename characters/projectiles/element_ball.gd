extends projectile_class

var speed = 900
var finish: Vector2

func ready():
	global_position = character.global_position
	look_at(get_global_mouse_position())
	finish = get_global_mouse_position()

func process(delta):
	global_position = global_position.move_toward(finish, delta * speed)
	if global_position == finish:
		die()

func on_death():
	tilemap.fill_circle(global_position, 8, element)
