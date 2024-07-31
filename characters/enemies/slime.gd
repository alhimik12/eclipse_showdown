extends enemy_class


var jump_dist = 200
var duration = 0.8
var angle_range = 110
var tween: Tween

func die():
	tilemap.fill_circle(global_position, 4.5, 0)
	super()

func wall_hit():
	super()
	if tween:
		tween.stop()

func move_timeout():
	var rot = get_angle_to(tilemap.sun.center)
	var ang_r = deg_to_rad(angle_range)
	rot += randf_range(-ang_r, ang_r)
	rot = (Vector2.from_angle(rot) - (global_position - player.global_position).normalized()).angle()
	var new_position = global_position + Vector2.RIGHT.rotated(rot) * get_speed(jump_dist)
	tween = create_tween()
	tween.set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUART)
	#tween.finished.connect(die)
	tween.tween_property(self, "global_position", new_position, duration)
	
	$dash_sound.play()


func delay_timeout():
	$move_timer.start()


func attack(a):
	$slimegun.use()
