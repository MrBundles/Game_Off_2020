tool
extends VBoxContainer
class_name Orchestrator

#constants
const GROUP_QUANTITY_MIN = 0
const GROUP_QUANTITY_MAX = 5
const CELL_QUANTITY_MIN = 0
const CELL_QUANTITY_MAX = 100

#exports
export var group_quantity = 0 setget _set_group_quantity
export var cell_quantity = 10 setget _set_cell_quantity
export(Array, GlobalSyncManager.ACTIONS) var action_array = [
	GlobalSyncManager.ACTIONS.disabled,
	GlobalSyncManager.ACTIONS.disabled,
	GlobalSyncManager.ACTIONS.disabled,
	GlobalSyncManager.ACTIONS.disabled,
	GlobalSyncManager.ACTIONS.disabled
] setget _set_action_array


func _set_group_quantity(new_val):
	group_quantity = clamp(new_val, GROUP_QUANTITY_MIN, GROUP_QUANTITY_MAX)
	
	#if there are too many children, cut off the extras
	if $OrchestratorGroups.get_child_count() > group_quantity:
		for i in range($OrchestratorGroups.get_child_count()):
			if i >= group_quantity:
				$OrchestratorGroups.get_child(i).queue_free()
	
	#if there are not enough children, remove all children and add back in the correct ammount
	if $OrchestratorGroups.get_child_count() < group_quantity:
		for child in $OrchestratorGroups.get_children():
			child.queue_free()
			
		for i in range(group_quantity):
			var group_instance = preload("res://UI/Orchestrator/OrchestratorGroup.tscn").instance()
			$OrchestratorGroups.add_child(group_instance)
			group_instance.action = action_array[i]


func _set_cell_quantity(new_val):
	cell_quantity = clamp(new_val, CELL_QUANTITY_MIN, CELL_QUANTITY_MAX)
	GlobalSyncManager.cell_quantity = cell_quantity
	
	for i in range($OrchestratorGroups.get_child_count()):
		$OrchestratorGroups.get_child(i).cell_quantity = cell_quantity


func _set_action_array(new_vals):
	action_array = new_vals
	for i in range($OrchestratorGroups.get_child_count()):
		$OrchestratorGroups.get_child(i).action = action_array[i]
