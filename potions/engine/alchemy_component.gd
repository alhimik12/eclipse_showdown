extends Node2D

var element_names = {0: "water", 1: "fire", 2: "wall", 3: "glow", 4: "freeze", 5: "scorch"}
var element_colors = {0: Color.SKY_BLUE, 1: Color.RED, 2: Color.PALE_GREEN, 3: Color.YELLOW, 4: Color.PURPLE, 5: Color.LIGHT_GOLDENROD}


func is_equivalent(el1, el2, v1, v2):
	return el1 == v1 and el2 == v2 or el1 == v2 and el2 == v1

func combine_elements(el1, el2):
	if el1 == el2:
		return el1
	elif el1 == -1 or el2 == -1:
		return el2
	elif is_equivalent(el1, el2, 0, 1):
		return 0
	elif is_equivalent(el1, el2, 0, 2):
		return 4
	elif is_equivalent(el1, el2, 0, 3):
		return 2
	elif is_equivalent(el1, el2, 1, 3):
		return 5
	elif is_equivalent(el1, el2, 1, 2):
		return -1
	elif is_equivalent(el1, el2, 2, 3):
		return 1
	elif is_equivalent(el1, el2, 4, 5):
		return -1
	elif is_equivalent(el1, el2, 4, 1):
		return 3
	elif el1 == 5 or el2 == 5:
		return 5
	elif el1 == 4 or el2 == 4:
		return 4
