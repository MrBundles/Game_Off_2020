tool
extends HBoxContainer
class_name orchestrator_group

#exports
export(GlobalSyncManager.ACTIONS) var action = GlobalSyncManager.ACTIONS.disabled

#variables
var temp_action = action


func _process(delta):
	if temp_action != action:
		_on_action_update()
		temp_action = action


func _on_action_update():
	for child in get_children():
		child.action = action
