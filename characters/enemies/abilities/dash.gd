extends ability_class

var power = 100
var angle = 0.8
var distance = 400
var tween: Tween

func activate():
	var direction = enemy.global_position.angle_to_point(player.global_position)
	if (enemy.global_position-player.global_position).length() <= distance:
		if randi_range(0, 1) == 1:
			direction += PI/2*angle
		else:
			direction -= PI/2*angle
	tween = create_tween()
	tween.set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	var new_global_position = enemy.global_position + Vector2.RIGHT.rotated(direction) * enemy.get_speed(power)
	tween.tween_property(enemy, "global_position", new_global_position, 0.3)

func cancel():
	if tween != null and tween.is_running():
		tween.stop()
