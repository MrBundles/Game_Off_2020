extends Label


func _process(delta):
	if get_parent().get_node("HBoxContainer/StartButton").pressed:
		text = "Stop"
	else:
		text = "Start"
