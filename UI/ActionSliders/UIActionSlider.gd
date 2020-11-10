extends TextureButton
class_name action_slider

#signals
signal slider_pressed

#exports
export var slider_width : int = 2

#variables
var slider_width_multiplier = 32
var slider_width_delta = 1

var slider_start_percent : float = 0.0
var slider_end_percent : float = 0.0

var mouse_pressed_offset = 0

#references
onready var action_slider_dock = get_parent().get_parent()


func _ready():
	#connect signals
	connect("slider_pressed", self, "_on_slider_pressed", [], CONNECT_ONESHOT)
	
	_update_slider()


func _process(delta):
	if pressed:
		emit_signal("slider_pressed")
		
		#move slider to mouse position
		var dock_left_limit = action_slider_dock.get_global_rect().position.x
		var dock_right_limit = action_slider_dock.get_global_rect().position.x + action_slider_dock.rect_size.x - rect_size.x
		rect_global_position.x = clamp(get_viewport().get_mouse_position().x - mouse_pressed_offset + dock_left_limit, dock_left_limit, dock_right_limit)
		
		#resize slider with mouse scroll
		if Input.is_action_just_released("mouse_scroll_up"):
			slider_width = clamp(slider_width + slider_width_delta, 0, action_slider_dock.rect_size.x / slider_width_multiplier)
		
		if Input.is_action_just_released("mouse_scroll_down"):
			slider_width = clamp(slider_width - slider_width_delta, 0, action_slider_dock.rect_size.x / slider_width_multiplier)
		
		#update slider info
		_update_slider()
		

func _update_slider():
	rect_size.x = slider_width * slider_width_multiplier
	var slider_left_limit = rect_position.x
	var slider_right_limit = rect_position.x + rect_size.x
	slider_start_percent = slider_left_limit / action_slider_dock.rect_size.x
	slider_end_percent = slider_right_limit / action_slider_dock.rect_size.x


func _on_slider_pressed():
		#initialize mouse position variable
		mouse_pressed_offset = get_viewport().get_mouse_position().x - rect_position.x


func _on_ActionSlider_button_up():
	#reconnect oneshot signal
	connect("slider_pressed", self, "_on_slider_pressed", [], CONNECT_ONESHOT)
