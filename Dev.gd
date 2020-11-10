extends Node2D


func _process(delta):
	if GlobalSyncManager.sync_action_enables[0]:
		$Sprite.show()
	else:
		$Sprite.hide()
