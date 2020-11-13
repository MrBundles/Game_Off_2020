tool
extends RigidBody2D
class_name Interacts

#enums
enum INTERACT_TYPES {interactable, interactor}

#variables
var interact_type = INTERACT_TYPES.interactable
var sync_array = []


func _ready():
	#connect signals
	GlobalSignalManager.connect("sync_timer_timeout", self, "_on_sync_timer_timeout")
	GlobalSignalManager.connect("sync_slider_moved", self, "_on_sync_slider_moved")
	GlobalSignalManager.connect("physics_state_changed", self, "_on_physics_state_changed")
	GlobalSignalManager.connect("game_state_changed", self, "_on_game_state_changed")
	
	for i in range(GlobalSyncManager.sync_subdiv_count):
		sync_array.append([global_position, rotation_degrees, linear_velocity, angular_velocity])


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
		
		if interact_type == INTERACT_TYPES.interactable:
			mode = RigidBody2D.MODE_RIGID
		else: 
			mode = RigidBody2D.MODE_STATIC
	
	elif new_physics_state == GlobalSceneManager.PHYSICS_STATES.stopped:
		if interact_type == INTERACT_TYPES.interactable:
			mode = RigidBody2D.MODE_KINEMATIC
		else:
			mode = RigidBody2D.MODE_STATIC


func _on_game_state_changed(new_game_state):
	if new_game_state == GlobalSceneManager.GAME_STATES.resetting:
		sync_array = []
