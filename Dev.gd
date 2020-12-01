extends Node2D

#variables
var physics_state_array = ["Running", "Stopped", "Rewinding"]
var game_state_array = ["Main Menu", "Settings Menu", "Credits Menu", "Level Select Menu",
	"Level Play", "Level Pause Menu", "Level Lose Menu", "Level Win Menu"]

func _process(delta):
	if has_node("UICanvasLayer/UILabel2"):
		get_node("UICanvasLayer/UILabel2").text = "Global Sync Cell Count: " + str(GlobalSyncManager.sync_cell_count)
