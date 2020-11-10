tool
extends VBoxContainer

#exports
export var dock_quantity = 1

#variables
var temp_dock_quantity = dock_quantity


func _process(delta):
	if dock_quantity != temp_dock_quantity:
		_update_dock_quantity(dock_quantity)
		temp_dock_quantity = dock_quantity


func _update_dock_quantity(qty):
	if get_child_count() > qty:
		for i in range(get_child_count()):
			if i >= qty:
				get_child(i).queue_free()
		
	if get_child_count() < qty:
		for i in range(qty - get_child_count()):
			var action_slider_dock_instance = preload("res://UI/ActionSliders/ActionSliderDock.tscn").instance()
			add_child(action_slider_dock_instance)
			action_slider_dock_instance.owner = self
