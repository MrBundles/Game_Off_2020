tool
extends TextureRect
class_name orchestrator_cell

#variables
var enable = false setget _set_enable
var action = GlobalSyncManager.ACTIONS.disabled setget _set_action
var cell_index = 0


func _ready():
	_set_enable(enable)
	_set_action(action)


func _process(delta):
	#if mouse is in cell
	if get_global_rect().has_point(get_global_mouse_position()):
		if Input.is_action_pressed("left_click"):
			_set_enable(true)
		
		if Input.is_action_pressed("right_click"):
			_set_enable(false)
		
	#if mouse is in cell or cell index is active
	if get_global_rect().has_point(get_global_mouse_position()) or GlobalSyncManager.sync_cell_current == cell_index:
		if enable:
			modulate = GlobalColorManager.action_color_array[action].darkened(.25)
		else:
			modulate = GlobalColorManager.action_color_array[action].lightened(.5)
	
	#if mouse is not in cell and cell index is not active
	else:
		if enable:
			modulate = GlobalColorManager.action_color_array[action]
		else:
			modulate = GlobalColorManager.action_color_array[action].lightened(.75)


func _set_enable(new_val):
	enable = new_val


func _set_action(new_val):
	action = new_val
