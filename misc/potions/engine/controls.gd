extends Node2D

@onready var tilemap = $".."
@onready var visuals = $"../visuals"

var selected_element = 0

func _process(delta):
	if Input.is_action_just_pressed("debug_attack"):
		tilemap.fill_circle(get_global_mouse_position(), 8, selected_element)
	if Input.is_action_just_pressed("select_up"):
		selected_element +=1
		if selected_element > 5:
			selected_element = 0
	if Input.is_action_just_pressed("select_down"):
		selected_element -=1
		if selected_element < 0:
			selected_element = 5
