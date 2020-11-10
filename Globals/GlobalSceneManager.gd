tool
extends Node

func _ready():
	#connect signals
	GlobalSignalManager.connect("reset_scene", self, "_on_reset_scene")


func _on_reset_scene():
	get_tree().reload_current_scene()
