
extends Node

#scene states
enum STATES {playing, paused}
var state = STATES.playing


func _ready():
	#connect signals
	GlobalSignalManager.connect("reset_scene", self, "_on_reset_scene")
	GlobalSignalManager.connect("pause_scene", self, "_on_pause_scene")
	GlobalSignalManager.connect("play_scene", self, "_on_play_scene")

	GlobalSignalManager.emit_signal("pause_scene")

func _on_reset_scene():
	get_tree().reload_current_scene()


func _on_pause_scene():
	get_tree().paused = true
	state = STATES.paused


func _on_play_scene():
	get_tree().paused = false
	state = STATES.playing
