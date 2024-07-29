extends gun_class


var max_ammo = 2
var ammo = max_ammo

func loadup():
	var cell_type = get_cell()
	if cell_type != -1:
		element = cell_type
		ammo = max_ammo
		clear_cells(cell_type)
		return true
	return false

func shoot(time_modifier):
	if shoot_timer.is_stopped():
		before_shoot()
		var proj_node = load(projectile).instantiate()
		proj_node.character = char
		if ammo != 0:
			proj_node.element = element
		else:
			proj_node.element = -1
		get_parent().get_parent().add_child(proj_node)
		after_shoot()
		ammo = max(ammo - 1, 0)
		shoot_timer.start(time_modifier * shoot_time)
