extends enemy_projectile_class

var start_distance = 40
var distance = 130
var duration = 0.3

func ready():
	global_position = character.global_position
	rotation = character.get_angle_to(character.player.global_position)
	global_position += Vector2.RIGHT.rotated(rotation) * start_distance

func init():
	var direction = Vector2.RIGHT.rotated(rotation)
	var new_position = global_position + direction * distance
	var tween = create_tween()
	tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUART)
	tween.finished.connect(die)
	tween.tween_property(self, "global_position", new_position, duration)
