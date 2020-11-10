tool
extends HBoxContainer
class_name orchestrator_group

#exports
export(GlobalSyncManager.ACTIONS) var action = GlobalSyncManager.ACTIONS.disabled setget _set_action


func _set_action(new_val):
	action = new_val
	
	for child in get_children():
		child.action = action
