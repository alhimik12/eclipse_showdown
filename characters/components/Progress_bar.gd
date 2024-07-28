extends Node2D

const TEXTURE_SIZE = 24.8

@export var length: float
@export var color_background: Color
@export var color_progress: Gradient
@export var centered: bool

var scale_bg = Vector2(0.05, 0.05)
var delta_size = 0.02

var progress: float = 100
var progress_max: float = 100

func _ready():
	$background.modulate = color_background
	$background.scale.x = length * scale_bg.x
	$background.scale.y = scale_bg.y
	
	change_progress_color(1.0)
	change_progress_scale(1.0)
	$progress.scale.y = scale_bg.y - delta_size
	update()

func change_progress_scale(k):
	if k == 0:
		$progress.scale.x = 0
	else:
		$progress.scale.x = length * k * scale_bg.x - delta_size

func change_progress_position(k):
	if not centered:
		$progress.position.x = 0.5*(TEXTURE_SIZE * length * (k - 1) - delta_size)
	else:
		$progress.position.x = 0

func change_progress_color(k):
	$progress.modulate = color_progress.sample(1-k)

func update(prog = progress):
	progress = prog
	var k = prog/progress_max
	change_progress_scale(k)
	change_progress_position(k)
	change_progress_color(k)
	
