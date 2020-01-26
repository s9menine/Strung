extends Node

export(float) var compressor_mix setget compressor_mix_setter

func compressor_mix_setter(value):
	AudioServer.get_bus_effect(AudioServer.get_bus_index("Instrument"), 0).mix = value
