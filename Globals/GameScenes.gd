extends CanvasLayer


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


func _on_level_select_menu_button_pressed():
	pass


func _on_credits_button_pressed():
	pass


func _on_settings_button_pressed():
	pass


func _on_back_button_pressed():
	pass


func _on_level_select_button_pressed():
	pass


func _on_pause_button_pressed():
	pass


func _on_level_lose():
	pass


func _on_level_win():
	pass


func _on_resume_button_pressed():
	pass


func _on_restart_button_pressed():
	pass


func _on_next_level_button_pressed():
	pass
