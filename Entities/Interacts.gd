tool
extends RigidBody2D
class_name Interacts


#variables
var initial_physics_mode = mode
var sync_array = []


func _ready():
	#connect signals
	GlobalSignalManager.connect("sync_timer_timeout", self, "_on_sync_timer_timeout")
	GlobalSignalManager.connect("sync_slider_moved", self, "_on_sync_slider_moved")
	GlobalSignalManager.connect("physics_state_changed", self, "_on_physics_state_changed")
	GlobalSignalManager.connect("game_state_changed", self, "_on_game_state_changed")
	
	for i in range(GlobalSyncManager.sync_subdiv_count):
		sync_array.append([global_position, rotation_degrees, linear_velocity, angular_velocity])
	
	initial_physics_mode = mode
	_on_physics_state_changed(GlobalSceneManager.physics_state)

func _update_interacts_state(sync_subdiv):
	global_position = sync_array[sync_subdiv][0]
	rotation_degrees = sync_array[sync_subdiv][1]
	linear_velocity = sync_array[sync_subdiv][2]
	angular_velocity = sync_array[sync_subdiv][3]


func _on_sync_timer_timeout():
	var interacts_data = [global_position, rotation_degrees, linear_velocity, angular_velocity]
	sync_array[GlobalSyncManager.sync_subdiv_current] = interacts_data


func _on_sync_slider_moved(value):
	_update_interacts_state(value)


func _on_physics_state_changed(new_physics_state):
	if new_physics_state == GlobalSceneManager.PHYSICS_STATES.running:
		_update_interacts_state(GlobalSyncManager.sync_subdiv_current)
		GlobalSyncManager.sync_subdiv_upper_limit_reached = GlobalSyncManager.sync_subdiv_current
		
		mode = initial_physics_mode
	
	else:
		mode = RigidBody2D.MODE_KINEMATIC


func _on_game_state_changed(new_game_state):
	if new_game_state == GlobalSceneManager.GAME_STATES.resetting:
		sync_array = []
