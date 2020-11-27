tool
extends HSlider

#variables
var sync_subdiv_count = GlobalSyncManager.sync_subdiv_count setget _set_sync_subdiv_count
var subdiv_per_cell = GlobalSyncManager.sync_subdiv_count / GlobalSyncManager.sync_cell_count

func _ready():
	_set_sync_subdiv_count(sync_subdiv_count)


func _process(delta):
	value = GlobalSyncManager.sync_subdiv_current


func _set_sync_subdiv_count(new_val):
	sync_subdiv_count = new_val
	max_value = sync_subdiv_count


func _on_SyncSlider_value_changed(new_val):
	if GlobalSceneManager.physics_state == GlobalSceneManager.PHYSICS_STATES.rewinding:
		if new_val > GlobalSyncManager.sync_subdiv_upper_limit_reached:
			value = GlobalSyncManager.sync_subdiv_upper_limit_reached
		
		GlobalSyncManager.sync_subdiv_current = value
		GlobalSignalManager.emit_signal("sync_slider_moved", value)
		
	if int(new_val) % int(subdiv_per_cell) == 0:
		GlobalSignalManager.emit_signal("new_sync_cell_reached", new_val / subdiv_per_cell)


func _on_SyncSlider_gui_input(event):
	if event is InputEventMouseButton and GlobalSceneManager.physics_state != GlobalSceneManager.PHYSICS_STATES.running:
		if event.is_pressed():
			GlobalSceneManager.physics_state = GlobalSceneManager.PHYSICS_STATES.rewinding
		else:
			GlobalSceneManager.physics_state = GlobalSceneManager.PHYSICS_STATES.stopped
