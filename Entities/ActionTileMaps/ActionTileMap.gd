tool
extends TileMap

#exports
export(GlobalSyncManager.ACTIONS) var action = GlobalSyncManager.ACTIONS.disabled

#variables
var enable = false


func _process(delta):
	if action != GlobalSyncManager.ACTIONS.disabled:
		if GlobalSyncManager.sync_action_enables[action]:
			modulate = GlobalColorManager.action_color_array[action]
			collision_mask = 0b1
		else:
			modulate = GlobalColorManager.action_color_array[action].lightened(.25)
			collision_mask = 0b0
	else:
		modulate = GlobalColorManager.action_color_array[action]
		collision_mask = 0b1
