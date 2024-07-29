class_name tile_map_class extends Node2D

@onready var alchemy = $alchemy_component
@onready var points = $points
@onready var visuals = $visuals
var last_pos

#var changed_cells = []

func dec2bin(decimal_value): 
	var binary_string = []
	var temp 
	var count = 3
	while(count >= 0): 
		temp = decimal_value >> count 
		if(temp & 1): 
			binary_string.append(1)
		else: 
			binary_string.append(0)
		count -= 1 
	return binary_string

func compute_ring(center, radius_main, radius, callable, arguments):
	var center_cell = get_cell_coords(center, points)
	var size = Vector2(radius_main * 2, radius_main * 2)
	var radius_circ = radius_main / 20
	var edges = [center.x - size.x/2, center.x + size.x/2,\
	 center.y - size.y/2, center.y + size.y/2]
	var up_left_corner = get_cell_coords(Vector2(edges[0], edges[2]), points)
	var pointer = up_left_corner
	var bounds = get_cell_coords(Vector2(center.x, edges[3]), points)
	while pointer.y <= bounds.y:
		pointer.x = up_left_corner.x
		var dist_to_center = (pointer-center_cell).length()
		while pointer.x <= bounds.x and dist_to_center >= radius:
			if dist_to_center <= radius_circ:
				print(radius_circ)
				compute_cell(pointer, callable, arguments)
				pointer.x += 1
				dist_to_center = (pointer-center_cell).length()
		pointer.y += 1
	
	var up_right_corner = get_cell_coords(Vector2(edges[1], edges[2]), points)
	pointer = up_right_corner
	bounds = get_cell_coords(Vector2(center.x, edges[3]), points )
	while pointer.y <= bounds.y:
		pointer.x = up_right_corner.x
		var dist_to_center = (pointer-center_cell).length()
		while pointer.x >= bounds.x and dist_to_center >= radius:
			if dist_to_center <= radius_circ:
				compute_cell(pointer, callable, arguments)
				pointer.x -= 1
				dist_to_center = (pointer-center_cell).length()
		pointer.y += 1

func compute_rectangle_with_hole(center, size, radius, callable, arguments):
	var center_cell = get_cell_coords(center, points)
	var edges = [center.x - size.x/2, center.x + size.x/2,\
	 center.y - size.y/2, center.y + size.y/2]
	var up_left_corner = get_cell_coords(Vector2(edges[0], edges[2]), points)
	var pointer = up_left_corner
	var bounds = get_cell_coords(Vector2(center.x, edges[3]), points)
	while pointer.y <= bounds.y:
		pointer.x = up_left_corner.x
		while pointer.x <= bounds.x and (pointer-center_cell).length() >= radius:
			compute_cell(pointer, callable, arguments)
			pointer.x += 1
		pointer.y += 1
	
	var up_right_corner = get_cell_coords(Vector2(edges[1], edges[2]), points)
	pointer = up_right_corner
	bounds = get_cell_coords(Vector2(center.x, edges[3]), points )
	while pointer.y <= bounds.y:
		pointer.x = up_right_corner.x
		while pointer.x >= bounds.x and (pointer-center_cell).length() >= radius:
			compute_cell(pointer, callable, arguments)
			pointer.x -= 1
		pointer.y += 1


func compute_rectangle(center, size, callable, arguments):
	var edges = [center.x - size.x/2, center.x + size.x/2,\
	 center.y - size.y/2, center.y + size.y/2]
	var up_left_corner = get_cell_coords(Vector2(edges[0], edges[2]), points)
	var pointer = up_left_corner
	var bounds = get_cell_coords(Vector2(edges[1], edges[3]), points)
	while pointer.y <= bounds.y:
		pointer.x = up_left_corner.x
		while pointer.x <= bounds.x:
			compute_cell(pointer, callable, arguments)
			pointer.x += 1
		pointer.y += 1
	
func get_cell_coords(coordinates: Vector2, node: TileMap):
	return node.local_to_map(node.to_local(coordinates))

func get_cell_direction(pos):
	var cell_atlas = visuals.get_cell_atlas_coords(2, get_cell_coords(pos, visuals))
	var lookup_table = visuals.sprite_vectors
	var decimal_direction = 0
	for i in range(len(lookup_table)):
		if lookup_table[i] == cell_atlas:
			decimal_direction = i
			break
	var bin_dir = dec2bin(decimal_direction)
	var direction = bin_dir[0] * Vector2(-1, -1) + bin_dir[1] * Vector2(-1, 1) + bin_dir[2] * Vector2(1, -1) + bin_dir[3] * Vector2(1, 1)
	return direction.normalized()
	
func compute_circle(center_pos, radius, callable, arguments):
	var changed_cells = []
	var center = get_cell_coords(center_pos, points)
	var pointer: Vector2i = center
	while (pointer-center).length() < radius:
		changed_cells += compute_cell(pointer, callable, arguments)
		changed_cells += compute_straight_line(pointer, center, radius, Vector2i.RIGHT, callable, arguments)
		changed_cells += compute_straight_line(pointer, center, radius, Vector2i.LEFT, callable, arguments)
		pointer += Vector2i.UP

	pointer = center + Vector2i.DOWN
	while (pointer-center).length() < radius:
		changed_cells += compute_cell(pointer, callable, arguments)
		changed_cells += compute_straight_line(pointer, center, radius, Vector2i.RIGHT, callable, arguments)
		changed_cells += compute_straight_line(pointer, center, radius, Vector2i.LEFT, callable, arguments)
		pointer += Vector2i.DOWN
	return changed_cells

func compute_cell(point, callable, arguments):
	callable.callv([point] + arguments)
	return [point]

func clear_cell(coordinates: Vector2i, type: int = 0):
	if points.get_cell_source_id(0, coordinates) == type:
		points.set_cell(0, coordinates, -1, Vector2i.ZERO)
		
func clear_circle(center_pos: Vector2, radius: float, type: int):
	visuals.refresh(compute_circle(center_pos, radius, Callable(self, "clear_cell"), [type]))

func fill_circle(center_pos: Vector2, radius: float, type: int):
	visuals.refresh(compute_circle(center_pos, radius, Callable(self, "fill_cell"), [type]))

func compute_straight_line(pointer: Vector2i, center: Vector2i, radius: float, direction: Vector2i, callable, arguments):
	var changed_cells = []
	pointer += direction
	while (pointer-center).length() < radius:
		changed_cells += compute_cell(pointer, callable, arguments)
		pointer += direction
	return changed_cells

func set_cell(coords, type):
	points.set_cell(0, coords, type, Vector2.ZERO)

func fill_cell(coordinates: Vector2i, type: int = 0):
	var new_type = alchemy.combine_elements(points.get_cell_source_id(0, coordinates), type)
	points.set_cell(0, coordinates, new_type, Vector2i.ZERO)

func get_cell_type(coordinates: Vector2):
	return points.get_cell_source_id(0, get_cell_coords(coordinates, points))

func _ready():
	#fill_circle(Vector2.ZERO, 8, 0)
	pass
