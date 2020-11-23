tool
extends Node

#enums
enum GAME_STATES {main_menu, settings_menu, credits_menu, level_select_menu, 
	level_play, level_pause_menu, level_lose_menu, level_win_menu}
enum PHYSICS_STATES {running, stopped, rewinding}

#variables
var physics_state_array = ["Running", "Stopped", "Rewinding"]
var game_state_array = ["Main Menu", "Settings Menu", "Credits Menu", "Level Select Menu",
	"Level Play", "Level Pause Menu", "Level Lose Menu", "Level Win Menu"]
var game_state = GAME_STATES.main_menu setget _set_game_state
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
	print("Physics state changed: " + physics_state_array[physics_state])


func _set_game_state(new_val):
	game_state = new_val
	print("Game state changed: " + game_state_array[game_state])








