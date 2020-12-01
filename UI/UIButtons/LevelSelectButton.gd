extends TextureButton

#exports
export var level_number = 1 setget _set_level_number
export(GlobalSyncManager.ACTIONS) var action = GlobalSyncManager.ACTIONS.disabled setget _set_action


func _process(delta):
	if level_number <= GlobalSceneManager.get_node("GameScenes").highest_unlocked_level:
		disabled = false
		self_modulate = GlobalColorManager.action_color_array[action]
	else:
		disabled = true
		self_modulate = GlobalColorManager.action_color_array[action].darkened(.5)


func _set_level_number(new_val):
	level_number = new_val
	$Label.text = str(level_number)


func _on_Button_pressed():
	GlobalSignalManager.emit_signal("sfx_level_select_press")
	
	if level_number < GlobalSceneManager.get_node("GameScenes").game_scene_array.size():
		GlobalSignalManager.emit_signal("level_select_button_pressed", level_number)


func _set_action(new_val):
	action = new_val


func _on_LevelSelectButton_mouse_entered():
	$LevelSelectHoverASP.play()
