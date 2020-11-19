tool
extends Node

#enums
enum PHYSICS_STATES {running, stopped, rewinding}
enum SCENE_TYPES {menu, game}

#variables
var physics_state = PHYSICS_STATES.stopped setget _set_physics_state

#exports
export var main_menu_scene_path = ""


func _ready():
	#connect signals
	GlobalSignalManager.connect("physics_state_changed", self, "_on_physics_state_changed")
	GlobalSignalManager.connect("play_button_pressed", self, "_on_play_button_pressed")
	GlobalSignalManager.connect("quit_button_pressed", self, "_on_quit_button_pressed")
	GlobalSignalManager.connect("continue_button_pressed", self, "_on_continue_button_pressed")
	GlobalSignalManager.connect("level_select_button_pressed", self, "_level_select_button_pressed")
	
	self.physics_state = PHYSICS_STATES.stopped
	
	#initialize main menu when game starts
	GlobalSignalManager.emit_signal("open_scene", SCENE_TYPES.menu, main_menu_scene_path)
	

func _on_physics_state_changed(new_physics_state):
	if new_physics_state == PHYSICS_STATES.running:
		pass
	if new_physics_state == PHYSICS_STATES.stopped:
		pass
	if new_physics_state == PHYSICS_STATES.rewinding:
		pass


func _on_play_button_pressed():
	pass


func _on_quit_button_pressed():
	pass


func _on_continue_button_pressed():
	pass


func _level_select_button_pressed(level_id):
	pass


func _set_physics_state(new_val):
	physics_state = new_val
	
	#emit signal
	GlobalSignalManager.emit_signal("physics_state_changed", physics_state)
	print("Physics state changed: " + str(physics_state))








