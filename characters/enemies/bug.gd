extends character_class

@onready var player: character_class = get_tree().get_first_node_in_group("player")
var speed = 200

func process(delta):
	global_position = global_position.move_toward(player.global_position, get_speed(speed) * delta)
