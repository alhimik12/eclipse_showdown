extends effect_class


func _process(delta):
	character.get_damage(-character.water_heal*0.8)
