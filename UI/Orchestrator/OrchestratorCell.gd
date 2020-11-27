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
	if get_global_rect().has_point(get_global_mouse_position()) and GlobalSceneManager.game_state != GlobalSceneManager.GAME_STATES.level_win_menu:
		if Input.is_action_pressed("left_click") and not enable:
			_set_enable(true)
			_emit_signal_physics_rewind_to_cell()
		
		if Input.is_action_pressed("right_click") and enable:
			_set_enable(false)
			_emit_signal_physics_rewind_to_cell()
		
	#if mouse is in cell or cell index is active
	if (get_global_rect().has_point(get_global_mouse_position()) or GlobalSyncManager.sync_cell_current == cell_index):
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


func _emit_signal_physics_rewind_to_cell():
	if cell_index <= GlobalSyncManager.sync_cell_current and GlobalSceneManager.physics_state != GlobalSceneManager.PHYSICS_STATES.rewinding:
		GlobalSignalManager.emit_signal("physics_rewind_to_cell", cell_index)

func _set_enable(new_val):
	enable = new_val


func _set_action(new_val):
	action = new_val
