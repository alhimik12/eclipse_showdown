extends effect_class

func _process(delta):
	character.move_damage(character.light_dmg, delta)
