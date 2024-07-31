extends Control



func master_slider(value):
	playsound()
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value)


func sfx_slider(value):
	playsound()
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), value)


func music_slider(value):
	playsound()
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("music"), value)

func playsound():
	Sfx.play("click.mp3")
