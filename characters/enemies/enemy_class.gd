class_name enemy_class extends character_class

@onready var player: character_class = get_tree().get_first_node_in_group("player")

func _ready():
	super()
	scorch_dmg *= 0.7
