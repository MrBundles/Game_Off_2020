tool
extends HSlider

#variables
var sync_subdiv_count = GlobalSyncManager.sync_subdiv_count setget _set_sync_subdiv_count


func _ready():
	_set_sync_subdiv_count(sync_subdiv_count)


func _process(delta):
	if GlobalSceneManager.physics_state == GlobalSceneManager.PHYSICS_STATES.running:
		value = GlobalSyncManager.sync_subdiv_current


func _set_sync_subdiv_count(new_val):
	sync_subdiv_count = new_val
	max_value = sync_subdiv_count


func _on_SyncSlider_value_changed(new_val):
	if GlobalSceneManager.physics_state == GlobalSceneManager.PHYSICS_STATES.stopped:
		if new_val > GlobalSyncManager.sync_subdiv_upper_limit_reached:
			value = GlobalSyncManager.sync_subdiv_upper_limit_reached
		
		GlobalSyncManager.sync_subdiv_current = value
		GlobalSignalManager.emit_signal("sync_slider_moved", value)
