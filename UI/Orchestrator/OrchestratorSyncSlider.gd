
extends HSlider

#variables
export var sync_subdiv_count = GlobalSyncManager.sync_subdiv_count setget _set_sync_subdiv_count


func _process(delta):
	if not get_tree().paused:
		value = GlobalSyncManager.sync_subdiv_current


func _set_sync_subdiv_count(new_val):
	sync_subdiv_count = new_val
	max_value = sync_subdiv_count


func _on_SyncSlider_value_changed(value):
	if get_tree().paused:
		GlobalSyncManager.sync_subdiv_current = value
