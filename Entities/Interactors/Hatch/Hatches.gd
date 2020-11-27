extends Node2D


func _process(delta):
	var total_remaining_qty = 0
	for hatch in get_children():
		total_remaining_qty += hatch.required_qty
	
	if total_remaining_qty < 1 and GlobalSceneManager.game_state != GlobalSceneManager.GAME_STATES.level_win_menu:
		GlobalSignalManager.emit_signal("level_win")
