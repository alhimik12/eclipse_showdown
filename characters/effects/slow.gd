extends effect_class

var slowdown = 0.4

func effect_start():
	character.speed_multiplyer *= slowdown

func effect_end():
	character.speed_multiplyer /= slowdown
