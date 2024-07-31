extends Control

@onready var option1: OptionButton = $VBoxContainer/HBoxContainer/VBoxContainer/OptionButton
@onready var option2: OptionButton = $VBoxContainer/HBoxContainer/VBoxContainer2/OptionButton
@onready var option3: OptionButton = $VBoxContainer/HBoxContainer/VBoxContainer/OptionButton2
@onready var option4: OptionButton = $VBoxContainer/HBoxContainer/VBoxContainer2/OptionButton2

func click(a = 0):
	Sfx.play("click.mp3")

func _on_start_button_down():
	Sfx.play("click.mp3")
	if option1.selected == -1 or option2.selected == -1 or option3.selected == -1 or option4.selected == -1:
		$Label2.show()
	else:
		LevelVariables.gun1 = option1.get_item_text(option1.selected)
		LevelVariables.gun2 = option2.get_item_text(option2.selected)
		LevelVariables.elem1 = option3.selected
		LevelVariables.elem2 = option4.selected
		#print(LevelVariables.gun1)
		#print(LevelVariables.gun2)
		#print(LevelVariables.elem1)
		#print(LevelVariables.elem2)
		get_tree().change_scene_to_file("res://levels/world.tscn")


func randomize_pressed():
	Sfx.play("click.mp3")
	random_option(option1)
	random_option(option2)
	random_option(option3)
	random_option(option4)



func random_option(option: OptionButton):
	option.selected = randi_range(0, option.item_count-1)
