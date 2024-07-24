extends projectile_class

var direction
var speed = 1200
var is_leaking = false

func ready():
	global_position = character.global_position
	look_at(get_global_mouse_position())
	direction = Vector2.RIGHT.rotated(rotation)

func on_start():
	area2d.monitoring = true
	is_leaking = true

func check_collision():
	pass

func process(delta):
	global_position += direction * speed * delta


func lifetime_timeout():
	die()


func leak_timeout():
	if is_leaking:
		tilemap.fill_circle(global_position, 2.5, element)
