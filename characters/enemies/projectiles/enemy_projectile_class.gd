class_name enemy_projectile_class extends projectile_class

@export var elemental_color: bool = false

func init():
	pass

func _ready():
	print(modulate)
	area2d.monitoring = true
	area2d.area_entered.connect(area_entered)
	if elemental_color:
		modulate = tilemap.alchemy.element_colors[element]
	
	start_timer.wait_time = start_time
	start_timer.one_shot = true
	start_timer.timeout.connect(on_start)
	add_child(start_timer)
	start_timer.start()
	ready()
