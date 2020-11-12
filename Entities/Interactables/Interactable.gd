extends RigidBody2D
class_name Interactable

#variables
var sync_array = []


func _ready():
	#connect signals
	GlobalSignalManager.connect("reset_scene", self, "_on_reset_scene")
	GlobalSignalManager.connect("pause_scene", self, "_on_pause_scene")
	GlobalSignalManager.connect("play_scene", self, "_on_play_scene")
	GlobalSignalManager.connect("sync_timer_timeout", self, "_on_sync_timer_timeout")
	GlobalSignalManager.connect("sync_slider_moved", self, "_on_sync_slider_moved")
	
	for i in range(GlobalSyncManager.sync_subdiv_count):
		sync_array.append([global_position, rotation_degrees, linear_velocity, angular_velocity])


func _update_interactable_state(sync_subdiv):
	global_position = sync_array[sync_subdiv][0]
	rotation_degrees = sync_array[sync_subdiv][1]
	linear_velocity = sync_array[sync_subdiv][2]
	angular_velocity = sync_array[sync_subdiv][3]


func _on_reset_scene():
	print(sync_array)
	sync_array = []


func _on_pause_scene():
	sleeping = true


func _on_play_scene():
	sleeping = false
	_update_interactable_state(GlobalSyncManager.sync_subdiv_current)


func _on_sync_slider_moved(value):
	_update_interactable_state(value)


func _on_sync_timer_timeout():
	var interactable_data = [global_position, rotation_degrees, linear_velocity, angular_velocity]
	sync_array[GlobalSyncManager.sync_subdiv_current] = interactable_data
