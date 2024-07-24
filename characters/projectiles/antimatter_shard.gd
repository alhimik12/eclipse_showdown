extends projectile_class

var direction
var speed = 1700
var spread = 20

func ready():
	hp = 2
	global_position = character.global_position
	look_at(get_global_mouse_position())
	rotation += deg_to_rad(randf_range(-spread, spread))
	direction = Vector2.RIGHT.rotated(rotation)
	
func process(delta):
	global_position += direction * speed * delta

func check_collision():
	var cell_type = tilemap.get_cell_type(global_position)
	if cell_type != -1:
		tilemap.clear_circle(global_position, 2, cell_type)
		get_damage(1)
