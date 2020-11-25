tool
extends VBoxContainer

#constants
const GROUP_QUANTITY_MIN = 0
const GROUP_QUANTITY_MAX = 5
const CELL_QUANTITY_MIN = 0
const CELL_QUANTITY_MAX = 100

#exports
export var group_quantity = 0 setget _set_group_quantity
export var cell_quantity = GlobalSyncManager.sync_cell_count setget _set_cell_quantity
export var time_total_duration = 5
export(Array, GlobalSyncManager.ACTIONS) var action_array = [
	GlobalSyncManager.ACTIONS.disabled,
	GlobalSyncManager.ACTIONS.disabled,
	GlobalSyncManager.ACTIONS.disabled,
	GlobalSyncManager.ACTIONS.disabled,
	GlobalSyncManager.ACTIONS.disabled
]


func _ready():
	_set_group_quantity(group_quantity)
	
	_set_cell_quantity(cell_quantity)
	GlobalSyncManager.sync_time_total_duration = time_total_duration


func _set_group_quantity(new_val):
	group_quantity = clamp(new_val, GROUP_QUANTITY_MIN, GROUP_QUANTITY_MAX)

	if has_node("OrchestratorGroups"):
		#if group quantity is not correct, remove all children and add back in the correct ammount
		if get_node("OrchestratorGroups").get_child_count() != group_quantity:
			for child in get_node("OrchestratorGroups").get_children():
				child.queue_free()

			for i in range(group_quantity):
				var group_instance = preload("res://UI/Orchestrator/OrchestratorGroup.tscn").instance()
				group_instance.action = action_array[i]
				get_node("OrchestratorGroups").add_child(group_instance)


func _set_cell_quantity(new_val):
	cell_quantity = clamp(new_val, CELL_QUANTITY_MIN, CELL_QUANTITY_MAX)
	GlobalSyncManager.sync_cell_count = cell_quantity
	
	if has_node("OrchestratorGroups"):
		for i in range(get_node("OrchestratorGroups").get_child_count()):
			get_node("OrchestratorGroups").get_child(i).cell_quantity = cell_quantity
