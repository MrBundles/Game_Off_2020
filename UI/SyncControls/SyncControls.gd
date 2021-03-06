extends HBoxContainer


func _ready():
	#connect signals
	GlobalSignalManager.connect("physics_state_changed", self, "_on_physics_state_changed")
	

func _process(delta):
	if GlobalSyncManager.sync_subdiv_current == GlobalSyncManager.sync_subdiv_count-1:
		_on_ResetButton_pressed()
	
	if GlobalSceneManager.game_state != GlobalSceneManager.GAME_STATES.level_win_menu:
		if Input.is_action_just_pressed("physics_start_stop"):
			$VBoxContainer3/HBoxContainer/StartButton.pressed = not $VBoxContainer3/HBoxContainer/StartButton.pressed
		
		if Input.is_action_just_pressed("physics_reset"):
			_on_ResetButton_pressed()
		
		if Input.is_action_just_pressed("pause_game"):
			$VBoxContainer/PauseButton.pressed = !$VBoxContainer/PauseButton.pressed
			_on_PauseButton_pressed()


func _on_physics_state_changed(new_physics_state):
	if new_physics_state == GlobalSceneManager.PHYSICS_STATES.rewinding:
		$VBoxContainer3/HBoxContainer/StartButton.disabled = true
		$VBoxContainer2/ResetButton.disabled = true
	else:
		$VBoxContainer3/HBoxContainer/StartButton.disabled = false
		$VBoxContainer2/ResetButton.disabled = false


func _on_StartButton_toggled(button_pressed):
	$StartStopPhysicsButtonASP.play()
	
	if GlobalSceneManager.physics_state != GlobalSceneManager.PHYSICS_STATES.rewinding:
		if button_pressed:
			GlobalSceneManager.physics_state = GlobalSceneManager.PHYSICS_STATES.running
		else:
			GlobalSceneManager.physics_state = GlobalSceneManager.PHYSICS_STATES.stopped


func _on_ResetButton_pressed():
	$StartStopPhysicsButtonASP.play()
	if GlobalSceneManager.physics_state != GlobalSceneManager.PHYSICS_STATES.rewinding:
		GlobalSignalManager.emit_signal("physics_reset_button_pressed")


func _on_PauseButton_pressed():
	$StartStopPhysicsButtonASP.play()
	
	if GlobalSceneManager.game_state == GlobalSceneManager.GAME_STATES.level_pause_menu:
		GlobalSignalManager.emit_signal("resume_button_pressed")
	elif GlobalSceneManager.game_state == GlobalSceneManager.GAME_STATES.level_play:
		GlobalSignalManager.emit_signal("pause_button_pressed")
