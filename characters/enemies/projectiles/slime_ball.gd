extends enemy_projectile_class

var direction
var speed = 7

func ready():
	global_position = character.global_position
	look_at(player.global_position)
	direction = Vector2.RIGHT.rotated(rotation)


func _process(delta):
	global_position += direction * speed
