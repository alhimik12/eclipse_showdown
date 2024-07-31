extends Node2D

func _ready():
	$death_sound.play()
	$GPUParticles2D.emitting = true

func _on_timer_timeout():
	queue_free()
