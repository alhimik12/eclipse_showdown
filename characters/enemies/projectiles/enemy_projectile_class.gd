class_name enemy_projectile_class extends projectile_class

@onready var player = get_tree().get_first_node_in_group("player")
@export var elemental_color: bool = false

func init():
	pass

func _ready():
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
