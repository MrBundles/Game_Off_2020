extends VBoxContainer



func _on_StartButton_toggled(button_pressed):
	GlobalSyncManager.sync_timer_start = button_pressed


func _on_ResetButton_pressed():
	GlobalSignalManager.emit_signal("reset_scene")
