extends TileMap

@onready var tilemap: tile_map_class = get_parent()
@onready var camera = get_tree().get_first_node_in_group("camera")
var center = Vector2.ZERO
var radius = 30
var light_width = 6
var width = 10
var clear_radius = 2

func fill_cell(coordinates: Vector2i, type: int = 0):
	#var new_type = alchemy.combine_elements(points.get_cell_source_id(0, coordinates), type)
	var new_type = type
	set_cell(0, coordinates, new_type, Vector2i.ZERO)

func clear_cell(coordinates: Vector2i, type: int = 0):
	if get_cell_source_id(0, coordinates) == type:
		set_cell(0, coordinates, -1, Vector2i.ZERO)

func create_sun(pos):
	tilemap.compute_circle(pos, radius + width, fill_cell, [5])
	tilemap.compute_circle(pos, radius + light_width, fill_cell, [3])
	tilemap.compute_circle(pos, radius, clear_cell, [3])	

func compute_visible_tiles():
	var camera_size = get_canvas_transform().affine_inverse().basis_xform(get_viewport_rect().size)
	var camera_pos = camera.global_position
	# Left Right Up Down
	var edges = [camera_pos.x - camera_size.x/2, camera_pos.x + camera_size.x/2,\
	 camera_pos.y - camera_size.y/2, camera_pos.y + camera_size.y/2]

func set_sun_cell(coords):
	var dist_to_center = (coords-tilemap.get_cell_coords(center, self)).length()
	if dist_to_center < radius:
		set_cell(0, coords, -1, Vector2i.ZERO)
	elif dist_to_center < radius + light_width:
		set_cell(0, coords, 3, Vector2i.ZERO)
	else:
		set_cell(0, coords, 5, Vector2i.ZERO)

func timer_timeout():
	center.x += 25 * $Timer.wait_time
	update()

func update():
	clear()
	tilemap.compute_rectangle_with_hole(center, Vector2(1, 1) * 60 * 32, radius-clear_radius, set_sun_cell, [])
	$shadow.global_position = center
	$shadow.scale = Vector2(1, 1) * 1 / 20 * (radius + width) * 0.9
