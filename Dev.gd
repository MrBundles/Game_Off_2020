extends Node2D

#variables
var physics_state_array = ["Running", "Stopped", "Rewinding"]
var game_state_array = ["Main Menu", "Settings Menu", "Credits Menu", "Level Select Menu",
	"Level Play", "Level Pause Menu", "Level Lose Menu", "Level Win Menu"]

func _process(delta):
	$Label.text = "Game State: " + game_state_array[GlobalSceneManager.game_state]
	$Label2.text = str($TitleP.sync_array)
