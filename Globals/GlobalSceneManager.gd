tool
extends Node

#enums
enum PHYSICS_STATES {running, stopped, rewinding}
enum GAME_STATES {playing, paused, menu, resetting}

#variables
var physics_state = PHYSICS_STATES.stopped setget _set_physics_state
var game_state = GAME_STATES.playing setget _set_game_state


func _ready():
	#connect signals
	GlobalSignalManager.connect("physics_state_changed", self, "_on_physics_state_changed")
	GlobalSignalManager.connect("game_state_changed", self, "_on_game_state_changed")
	
	self.physics_state = PHYSICS_STATES.stopped


func _on_physics_state_changed(new_physics_state):
	if new_physics_state == PHYSICS_STATES.running:
		pass
	if new_physics_state == PHYSICS_STATES.stopped:
		pass
	if new_physics_state == PHYSICS_STATES.rewinding:
		pass


func _on_game_state_changed(new_game_state):
	if new_game_state == GAME_STATES.playing:
		get_tree().paused = false
	if new_game_state == GAME_STATES.paused:
		get_tree().paused = true
	if new_game_state == GAME_STATES.menu:
		pass
	if new_game_state == GAME_STATES.resetting:
		get_tree().reload_current_scene()
		yield(get_tree(), "idle_frame")
		self.game_state = GAME_STATES.playing


func _set_physics_state(new_val):
	physics_state = new_val
	
	#emit signal
	GlobalSignalManager.emit_signal("physics_state_changed", physics_state)
	print("Physics state changed: " + str(physics_state))


func _set_game_state(new_val):
	game_state = new_val
	
	#emit signal
	GlobalSignalManager.emit_signal("game_state_changed", game_state)
	print("Game state changed: " + str(game_state))








