tool
extends TextureButton

#exports
export var button_label = "UIButton" setget _set_button_label
export var transition_signal = ""
export(GlobalSyncManager.ACTIONS) var action = GlobalSyncManager.ACTIONS.disabled setget _set_action


func _set_button_label(new_val):
	button_label = new_val
	$Label.text = button_label


func _on_Button_pressed():
	GlobalSignalManager.emit_signal("sfx_ui_button_press")
	
	if GlobalSignalManager.has_signal(transition_signal):
		GlobalSignalManager.emit_signal(transition_signal)
	else:
		print("invalid signal triggered by button")


func _set_action(new_val):
	action = new_val
	self_modulate = GlobalColorManager.action_color_array[action]


func _on_UIButton_mouse_entered():
	$UIButtonHoverASP.play()
