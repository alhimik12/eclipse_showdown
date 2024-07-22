extends effect_class

func effect_start():
	character.not_frozen = false


func effect_end():
	character.not_frozen = true
