extends TileMap

@onready var points = $"../points"
var cell_points = {}

func _ready():
	update()

func refresh(new_points):
	var cell_new = []
	for point in new_points:
		call_from_point(clear_point, [point, 0, 0, 0])
		for layer in range(6):
			call_from_point(remove_from_dict, [point, cell_points, 0, layer])
		var layer = points.get_cell_source_id(0, point)
		
		call_from_point(add_to_list, [point, cell_new, 0, layer])
		
		call_from_point(add_to_dict, [point, cell_points, 0, layer])

	for key in cell_new:
		for layer in range(6):
			var real_key = [key[0]]+[layer]
			if cell_points.has(real_key):
				var values = cell_points[real_key]
				var cell = key[0]
				var cell_type = get_cell_type(values)
				set_cell(layer, cell, 0, cell_type)

func clear_point(point, _a, _b, _c):
	for layer in range(6):
		set_cell(layer, point)

func update():
	clear()
	cell_points = {}
	var point_array = points.get_used_cells(0)
	for point in point_array:
		var layer = points.get_cell_source_id(0, point)
		call_from_point(add_to_dict, [point, cell_points, 0, layer])

	var keys = cell_points.keys()
	for key in keys:
		var values = cell_points[key]
		var layer = key[1]
		var cell = key[0]
		var cell_type = get_cell_type(values)
		set_cell(layer, cell, 0, cell_type)

func call_from_point(callable, args):
	var arg = args
	callable.callv(args)
	callable.callv([args[0]-Vector2i.DOWN, args[1], 1, args[3]])
	callable.callv([args[0]-Vector2i.RIGHT, args[1], 2, args[3]])
	callable.callv([args[0]-Vector2i.RIGHT-Vector2i.DOWN, args[1], 3, args[3]])

func add_to_list(point, list, index, layer):
	if not list.has([point, layer]):
		list.append([point, layer])

func remove_from_dict(point, cell_points, index, layer):
		if cell_points.has([point, layer]):
			cell_points[[point, layer]][index] = 0
			if cell_points[[point, layer]] == [0, 0, 0, 0]:
				cell_points.erase([[point, layer]])

func add_to_dict(point, cell_points, index, layer):
		if !cell_points.has([point, layer]):
			cell_points[[point, layer]] = [0, 0, 0, 0]
		cell_points[[point, layer]][index] = 1
		
var sprite_vectors = [
	Vector2i(0, 0),  # 0000 
	Vector2i(2, 0),  # 0001 
	Vector2i(2, 1),  # 0010 
	Vector2i(5, 0),  # 0011 
	Vector2i(1, 0),  # 0100 
	Vector2i(3, 0),  # 0101 
	Vector2i(4, 0),  # 0110 
	Vector2i(5, 1),  # 0111 
	Vector2i(0, 1),  # 1000 
	Vector2i(4, 1),  # 1001 
	Vector2i(3, 1),  # 1010 
	Vector2i(7, 1),  # 1011 
	Vector2i(1, 1),  # 1100 
	Vector2i(6, 0),  # 1101 
	Vector2i(6, 1),  # 1110 
	Vector2i(7, 0)   # 1111 
]

func get_cell_type(values):
	var a = values[0]
	var b = values[1]
	var c = values[2]
	var d = values[3]
	return sprite_vectors[a*8+b*4+c*2+d]
	
