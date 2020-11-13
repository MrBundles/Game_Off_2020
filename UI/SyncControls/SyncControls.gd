extends VBoxContainer



func _on_StartButton_toggled(button_pressed):
	if button_pressed:
		GlobalSceneManager.physics_state = GlobalSceneManager.PHYSICS_STATES.running
	else:
		GlobalSceneManager.physics_state = GlobalSceneManager.PHYSICS_STATES.stopped


func _on_ResetButton_pressed():
	GlobalSceneManager.game_state = GlobalSceneManager.GAME_STATES.resetting
