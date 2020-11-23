extends CanvasLayer

#exports
export(PackedScene) var main_menu
export (PackedScene) var settings_menu
export (PackedScene) var credits_menu
export (PackedScene) var level_select_menu
export (PackedScene) var level_pause_menu
export (PackedScene) var level_lose_menu
export (PackedScene) var level_win_menu


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

	add_child(main_menu.instance())


func _process(delta):
	if GlobalSceneManager.game_state == GlobalSceneManager.GAME_STATES.main_menu:
		pass
	elif GlobalSceneManager.game_state == GlobalSceneManager.GAME_STATES.main_menu:
		pass

func _clear_children():
	for child in get_children():
		child.queue_free()


func _on_level_select_menu_button_pressed():
	_clear_children()
	add_child(level_select_menu.instance())
	GlobalSceneManager.game_state = GlobalSceneManager.GAME_STATES.level_select_menu


func _on_credits_button_pressed():
	_clear_children()
	add_child(credits_menu.instance())
	GlobalSceneManager.game_state = GlobalSceneManager.GAME_STATES.credits_menu


func _on_settings_button_pressed():
	_clear_children()
	add_child(settings_menu.instance())
	GlobalSceneManager.game_state = GlobalSceneManager.GAME_STATES.settings_menu


func _on_back_button_pressed():
	_clear_children()
	add_child(main_menu.instance())
	GlobalSceneManager.game_state = GlobalSceneManager.GAME_STATES.main_menu


func _on_level_select_button_pressed(level_number):
	_clear_children()


func _on_pause_button_pressed():
	_clear_children()
	add_child(level_pause_menu.instance())
	GlobalSceneManager.game_state = GlobalSceneManager.GAME_STATES.level_pause_menu


func _on_level_lose():
	_clear_children()
	add_child(level_lose_menu.instance())
	GlobalSceneManager.game_state = GlobalSceneManager.GAME_STATES.level_lose_menu


func _on_level_win():
	_clear_children()
	add_child(level_win_menu.instance())
	GlobalSceneManager.game_state = GlobalSceneManager.GAME_STATES.level_win_menu


func _on_resume_button_pressed():
	_clear_children()


func _on_restart_button_pressed():
	_clear_children()


func _on_next_level_button_pressed():
	_clear_children()
