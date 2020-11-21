extends Node2D

#variables
var physics_state_array = ["Running", "Stopped", "Rewinding"]

func _process(delta):
	$Label.text = "Physics State: " + physics_state_array[GlobalSceneManager.physics_state]
	$Label2.text = "Sync Subdiv Current: " + str(GlobalSyncManager.sync_subdiv_current)
