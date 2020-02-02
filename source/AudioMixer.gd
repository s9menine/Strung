extends Node

export(float, EXP, -80.0, 0.0) var master_volume setget _setter, _getter

func _setter(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value)
	master_volume = value


func _getter():
	return master_volume
