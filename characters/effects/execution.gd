extends effect_class

func effect_start():
	$animation.play("new_animation")

func effect_end():
	if not is_cleared:
		character.get_damage(50)
