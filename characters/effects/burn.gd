extends effect_class

var dmg = 7

func _process(delta):
	character.get_damage(dmg*delta)
	if timer.time_left < 0.6:
		$particles.emitting = false
	else:
		$particles.emitting = true
