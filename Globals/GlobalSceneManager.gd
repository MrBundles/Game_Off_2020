tool
extends Node

#enums
enum GAME_STATES {main_menu, settings_menu, credits_menu, level_select_menu, 
	level_play, level_pause_menu, level_lose_menu, level_win_menu}
enum PHYSICS_STATES {running, stopped, rewinding}

#variables
var game_state = GAME_STATES.main_menu
var physics_state = PHYSICS_STATES.stopped setget _set_physics_state


func _ready():
	#connect signals
	GlobalSignalManager.connect("physics_state_changed", self, "_on_physics_state_changed")
	GlobalSignalManager.connect("quit_button_pressed", self, "_on_quit_button_pressed")

	self.physics_state = PHYSICS_STATES.stopped


func _on_physics_state_changed(new_physics_state):
	if new_physics_state == PHYSICS_STATES.running:
		pass
	if new_physics_state == PHYSICS_STATES.stopped:
		pass
	if new_physics_state == PHYSICS_STATES.rewinding:
		pass


func _on_quit_button_pressed():
	get_tree().quit()


func _set_physics_state(new_val):
	physics_state = new_val
	
	#emit signal
	GlobalSignalManager.emit_signal("physics_state_changed", physics_state)
	print("Physics state changed: " + str(physics_state))








