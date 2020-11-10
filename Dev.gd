extends Node2D


func _process(delta):
	$Label.text = str(GlobalSyncManager.sync_index)
