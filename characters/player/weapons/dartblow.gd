extends gun_class


var max_ammo = 1
var ammo = max_ammo

func loadup():
	if ammo < max_ammo:
		var cell_type = get_cell()
		if cell_type != -1:
			ammo = max_ammo
			clear_cells(cell_type)
			return true
	return false

func shoot(time_modifier):
	if ammo > 0:
		if shoot_timer.is_stopped():
			before_shoot()
			var proj_node = load(projectile).instantiate()
			proj_node.character = char
			proj_node.element = element
			get_parent().get_parent().add_child(proj_node)
			after_shoot()
			ammo -= 1
			shoot_timer.start(time_modifier * shoot_time)
