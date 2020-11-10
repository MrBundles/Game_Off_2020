tool
extends TextureRect
class_name orchestrator_cell

#variables
var enabled = false
var action = GlobalSyncManager.ACTIONS.disabled
var temp_action = action


func _ready():
	_on_enable_update()


func _process(delta):
	if not Engine.editor_hint:
		if temp_action != action:
			_on_action_update()
			temp_action = action


func _on_mouse_entered():
	if Input.is_action_pressed("left_click"):
		enabled = true
		_on_enable_update()
	elif Input.is_action_pressed("right_click"):
		enabled = false
		_on_enable_update()


func _on_enable_update():
	modulate = GlobalColorManager.action_color_array[action]
	if enabled:
		modulate.a8 = 255
	else:
		modulate.a8 = 100


func _on_action_update():	#I know this function is only doing one thing for now...
	_on_enable_update()
