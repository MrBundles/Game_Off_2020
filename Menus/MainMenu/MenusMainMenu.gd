extends Control


func _on_PlayButton_pressed():
	GlobalSignalManager.emit_signal("play_button_pressed")


func _on_LevelSelectButton_pressed():
	GlobalSignalManager.emit_signal("level_select_button_pressed")


func _on_SettingsButton_pressed():
	pass


func _on_CreditsButton_pressed():
	pass


func _on_QuitButton_pressed():
	GlobalSignalManager.emit_signal("quit_button_pressed")
