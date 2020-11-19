extends HBoxContainer


func _ready():
	if GlobalSceneManager.physics_state == GlobalSceneManager.PHYSICS_STATES.running:
		$StartButton.pressed = true


func _on_StartButton_toggled(button_pressed):
	if button_pressed:
		GlobalSceneManager.physics_state = GlobalSceneManager.PHYSICS_STATES.running
	else:
		GlobalSceneManager.physics_state = GlobalSceneManager.PHYSICS_STATES.stopped


func _on_ResetButton_pressed():
		GlobalSignalManager.emit_signal("physics_reset_button_pressed")
