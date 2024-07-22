extends gun_class

var max_ammo = 2
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
		for i in range(3):
			super(time_modifier)
		ammo -= 1
