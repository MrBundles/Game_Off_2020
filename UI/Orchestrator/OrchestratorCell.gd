tool
extends TextureRect
class_name orchestrator_cell

#variables
var enable = false setget _set_enable
var action = GlobalSyncManager.ACTIONS.disabled setget _set_action


func _ready():
	_set_enable(enable)


func _on_mouse_entered():
	#if left mouse button is down
	if Input.is_action_pressed("left_click"):
		_set_enable(true)
	
	#if right mouse button is down
	elif Input.is_action_pressed("right_click"):
		_set_enable(false)
		


func _on_mouse_exited():
	pass

func _set_enable(new_val):
	enable = new_val
	
	if enable:
		modulate = GlobalColorManager.action_color_array[action]
	else:
		modulate = GlobalColorManager.action_color_array[action]


func _set_action(new_val):
	action = new_val
	_set_enable(enable)
