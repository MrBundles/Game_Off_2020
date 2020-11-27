tool
extends RigidBody2D
class_name Interacts

#signals
signal load_sync_data

#enums
enum INTERACT_MODES {mode_rigid, mode_static, mode_character, mode_kinematic}


#variables
var initial_physics_mode = INTERACT_MODES.mode_kinematic
var sync_array = []
var sync_data = []
var physics_state_array = []


func _ready():
	#connect signals
	GlobalSignalManager.connect("sync_timer_timeout", self, "_on_sync_timer_timeout")
	GlobalSignalManager.connect("sync_slider_moved", self, "_on_sync_slider_moved")
	GlobalSignalManager.connect("physics_state_changed", self, "_on_physics_state_changed")
	GlobalSignalManager.connect("new_sync_cell_reached", self, "_on_new_sync_cell_reached")
	
	for i in range(GlobalSyncManager.sync_subdiv_count):
		sync_array.append(sync_data)
	
	for j in range(GlobalSyncManager.sync_cell_count):
		physics_state_array.append(Physics2DServer.body_get_state(get_rid(), Physics2DServer.BODY_STATE_TRANSFORM))
	
	_on_physics_state_changed(GlobalSceneManager.physics_state)


func _on_physics_state_changed(new_physics_state):
	if new_physics_state == GlobalSceneManager.PHYSICS_STATES.running:
		if int(GlobalSyncManager.sync_subdiv_current) % int(GlobalSyncManager.subdiv_per_cell) == 0:
			Physics2DServer.body_set_state(get_rid(), Physics2DServer.BODY_STATE_TRANSFORM, physics_state_array[GlobalSyncManager.sync_cell_current+1])

		_reset_sync_array(GlobalSyncManager.sync_subdiv_current)
		emit_signal("load_sync_data", GlobalSyncManager.sync_subdiv_current)
		GlobalSyncManager.sync_subdiv_upper_limit_reached = GlobalSyncManager.sync_subdiv_current
		
		mode = initial_physics_mode
	
	else:
		mode = RigidBody2D.MODE_KINEMATIC


func _on_new_sync_cell_reached(cell_index):
	physics_state_array[cell_index] = Physics2DServer.body_get_state(get_rid(), Physics2DServer.BODY_STATE_TRANSFORM)


func _reset_sync_array(current_subdiv):
	for i in range(current_subdiv, sync_array.size()):
		sync_array[i] = sync_data


func _on_sync_timer_timeout():
	sync_array[GlobalSyncManager.sync_subdiv_current] = sync_data


func _on_sync_slider_moved(value):
	emit_signal("load_sync_data", GlobalSyncManager.sync_subdiv_current)
