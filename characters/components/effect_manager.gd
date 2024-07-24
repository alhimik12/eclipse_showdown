extends Node2D

var effects = {\
 "slow": preload("res://characters/effects/slow.tscn"),\
 "burn": preload("res://characters/effects/burn.tscn"),\
 "stun": preload("res://characters/effects/stun.tscn"),\
 "blind": preload("res://characters/effects/blind.tscn"),\
 "frozen": preload("res://characters/effects/frozen.tscn"),\
 "execution": preload("res://characters/effects/execution.tscn")}
var has_effect: Dictionary = {"slow": false, "burn": false, "stun": false, "blind": false, "frozen": false, "execution": false}

func apply_effect(effect):
	if has_effect[effect]:
		get_node(effect).extend()
	else:
		var effect_node = effects[effect].instantiate()
		effect_node.character = get_parent()
		add_child(effect_node)

func delete_effect(effect):
	if has_effect[effect]:
		get_node(effect).clear_effect()
		
func clear_effects():
	for i in has_effect.keys():
		delete_effect(i)
