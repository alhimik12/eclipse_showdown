extends Node2D

@onready var tilemap: tile_map_class = get_tree().get_first_node_in_group("tilemap")

func _ready():
	for i in range(6):
		var center = Vector2.RIGHT.rotated(2 * PI / 6 * i) * 500
		tilemap.fill_circle(center, 9.5, i)
