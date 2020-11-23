extends CanvasLayer

#exports
export(Array, PackedScene) var game_scene_array

#variables
var current_level = 0


func _ready():
	#connect signals
	GlobalSignalManager.connect("level_select_menu_button_pressed", self, "_on_level_select_menu_button_pressed")
	GlobalSignalManager.connect("credits_button_pressed", self, "_on_credits_button_pressed")
	GlobalSignalManager.connect("settings_button_pressed", self, "_on_settings_button_pressed")
	GlobalSignalManager.connect("back_button_pressed", self, "_on_back_button_pressed")
	GlobalSignalManager.connect("level_select_button_pressed", self, "_on_level_select_button_pressed")
	GlobalSignalManager.connect("pause_button_pressed", self, "_on_pause_button_pressed")
	GlobalSignalManager.connect("level_lose", self, "_on_level_lose")
	GlobalSignalManager.connect("level_win", self, "_on_level_win")
	GlobalSignalManager.connect("resume_button_pressed", self, "_on_resume_button_pressed")
	GlobalSignalManager.connect("restart_button_pressed", self, "_on_restart_button_pressed")
	GlobalSignalManager.connect("next_level_button_pressed", self, "_on_next_level_button_pressed")
	
	add_child(game_scene_array[0].instance())


func _reset_game_data():
	GlobalSceneManager.physics_state = GlobalSceneManager.PHYSICS_STATES.stopped


func _clear_children():
	for child in get_children():
		child.queue_free()


func _on_level_select_menu_button_pressed():
	get_tree().paused = false
	_clear_children()
	add_child(game_scene_array[0].instance())
	current_level = 0
	_reset_game_data()


func _on_credits_button_pressed():
	pass


func _on_settings_button_pressed():
	pass


func _on_back_button_pressed():
	pass


func _on_level_select_button_pressed(level_number):
	_clear_children()
	add_child(game_scene_array[level_number].instance())
	current_level = level_number
	_reset_game_data()
	GlobalSceneManager.game_state = GlobalSceneManager.GAME_STATES.level_play
	GlobalSignalManager.emit_signal("restart_button_pressed")


func _on_pause_button_pressed():
	get_tree().paused = true


func _on_level_lose():
	pass


func _on_level_win():
	pass


func _on_resume_button_pressed():
	get_tree().paused = false
	GlobalSceneManager.game_state = GlobalSceneManager.GAME_STATES.level_play


func _on_restart_button_pressed():
	get_tree().paused = false
	_clear_children()
	add_child(game_scene_array[current_level].instance())
	_reset_game_data()
	GlobalSceneManager.game_state = GlobalSceneManager.GAME_STATES.level_play


func _on_next_level_button_pressed():
	GlobalSceneManager.game_state = GlobalSceneManager.GAME_STATES.level_play
