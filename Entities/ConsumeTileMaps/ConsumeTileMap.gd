tool
extends TileMap

#exports
export(GlobalSyncManager.ACTIONS) var action = GlobalSyncManager.ACTIONS.disabled


func _ready():
	modulate = GlobalColorManager.action_color_array[action]
