tool
extends Control

#exports
export(GlobalSyncManager.ACTIONS) var action = GlobalSyncManager.ACTIONS.disabled
export var action_slider_quantity = 1

#variables
var temp_action_slider_quantity = action_slider_quantity
var max_action_slider_quantity = 10
var min_action_slider_quantity = 0


func _ready():
	_update_action_slider_quantity(action_slider_quantity)


func _process(delta):
	if temp_action_slider_quantity != action_slider_quantity:
		_update_action_slider_quantity(action_slider_quantity)
		temp_action_slider_quantity = action_slider_quantity
	
	if not Engine.editor_hint:
		#iterate through all action sliders and check if the sync timer percent overlaps the slider percent
		var action_slider_enable_counter = 0
		for child in $ActionSliders.get_children():
			if GlobalSyncManager.sync_timer_percent_elapsed >= child.slider_start_percent:
				if GlobalSyncManager.sync_timer_percent_elapsed <= child.slider_end_percent:
					action_slider_enable_counter += 1
		
		GlobalSyncManager.sync_action_enables[action] = action_slider_enable_counter > 0
		
		$SyncTimerPointer.rect_position.x = rect_size.x * GlobalSyncManager.sync_timer_percent_elapsed


func _update_action_slider_modulate():
	for child in $ActionSliders.get_children():
		child.modulate = GlobalColorManager.action_color_array[action]


func _update_action_slider_quantity(qty):
	if $ActionSliders.get_child_count() > qty:
		for i in range($ActionSliders.get_child_count()):
			if i >= qty:
				$ActionSliders.get_child(i).queue_free()
		
	if $ActionSliders.get_child_count() < qty:
		for i in range(qty - $ActionSliders.get_child_count()):
			var action_slider_dock_instance = preload("res://UI/ActionSliders/ActionSlider.tscn").instance()
			$ActionSliders.add_child(action_slider_dock_instance)
			action_slider_dock_instance.owner = self
	
	$HBoxContainer/SliderQtyLabel.text = str(qty)
	
	_update_action_slider_modulate()


func _on_AddSliderButton_pressed():
	action_slider_quantity = clamp(action_slider_quantity + 1, min_action_slider_quantity, max_action_slider_quantity)


func _on_RemoveSliderButton_pressed():
	action_slider_quantity = clamp(action_slider_quantity - 1, min_action_slider_quantity, max_action_slider_quantity)
