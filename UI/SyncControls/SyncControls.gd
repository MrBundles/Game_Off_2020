extends HBoxContainer


func _ready():
	#connect signals
	GlobalSignalManager.connect("physics_state_changed", self, "_on_physics_state_changed")
	
	if GlobalSceneManager.physics_state == GlobalSceneManager.PHYSICS_STATES.running:
		$StartButton.pressed = true


func _process(delta):
	if GlobalSyncManager.sync_subdiv_current == GlobalSyncManager.sync_subdiv_count-1:
		_on_ResetButton_pressed()


func _on_physics_state_changed(new_physics_state):
	if new_physics_state == GlobalSceneManager.PHYSICS_STATES.rewinding:
		$StartButton.disabled = true
	else:
		$StartButton.disabled = false


func _on_StartButton_toggled(button_pressed):
	if GlobalSceneManager.physics_state != GlobalSceneManager.PHYSICS_STATES.rewinding:
		if button_pressed:
			GlobalSceneManager.physics_state = GlobalSceneManager.PHYSICS_STATES.running
		else:
			GlobalSceneManager.physics_state = GlobalSceneManager.PHYSICS_STATES.stopped


func _on_ResetButton_pressed():
	if GlobalSceneManager.physics_state != GlobalSceneManager.PHYSICS_STATES.rewinding:
		GlobalSignalManager.emit_signal("physics_reset_button_pressed")
