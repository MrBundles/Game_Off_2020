tool
extends TextureButton

#exports
export var button_label = "UIButton" setget _set_button_label
export var transition_signal = ""


func _set_button_label(new_val):
	button_label = new_val
	$Label.text = button_label


func _on_Button_pressed():
	if GlobalSignalManager.has_signal(transition_signal):
		GlobalSignalManager.emit_signal(transition_signal)
	else:
		print("invalid signal triggered by button")
