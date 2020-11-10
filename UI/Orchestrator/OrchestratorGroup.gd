tool
extends HBoxContainer
class_name orchestrator_group

#exports
export(GlobalSyncManager.ACTIONS) var action = GlobalSyncManager.ACTIONS.disabled setget _set_action
export var cell_quantity = 1 setget _set_cell_quantity


func _process(delta):
	var enable_count = 0
	for i in range(get_child_count()):
		if GlobalSyncManager.sync_index == i and get_child(i).enable:
			enable_count += 1
	
	GlobalSyncManager.sync_action_enables[action] = enable_count > 0


func _set_action(new_val):
	action = new_val
	
	for child in get_children():
		child.action = action


func _set_cell_quantity(new_val):
	cell_quantity = new_val
	
	if get_child_count() > cell_quantity:
		for i in range(get_child_count()):
			if i >= cell_quantity:
				get_child(i).queue_free()
		
	if get_child_count() < cell_quantity:
		for i in range(cell_quantity - get_child_count()):
			var cell_instance = preload("res://UI/Orchestrator/OrchestratorCell.tscn").instance()
			add_child(cell_instance)
	
	for i in range(get_child_count()):
		get_child(i).cell_index = i
