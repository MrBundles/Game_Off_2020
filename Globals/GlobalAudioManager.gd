tool
extends Node


func _ready():
	#connect signals
	GlobalSignalManager.connect("volume_changed", self, "_on_volume_changed")
	GlobalSignalManager.connect("mute_changed", self, "_on_mute_changed")


func _on_volume_changed(audio_bus, new_val):
	AudioServer.set_bus_volume_db(audio_bus, new_val)


func _on_mute_changed(audio_bus, new_val):
	AudioServer.set_bus_mute(audio_bus, new_val)
