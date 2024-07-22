extends projectile_class

func ready():
	global_position = get_global_mouse_position()
	die()

func on_death():
	create_ring()

func create_ring():
	tilemap.fill_circle(global_position, 10, element)
	tilemap.clear_circle(global_position, 6.5, element)
