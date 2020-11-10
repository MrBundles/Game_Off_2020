extends Node2D


func _process(delta):
	#update sprite modulations based on the interactor calling the tooltip
	$ActionSpriteA.modulate = GlobalColorManager.action_color_array[get_parent().action_a]
	$ActionSpriteB.modulate = GlobalColorManager.action_color_array[get_parent().action_b]
	
	#move tooltip to mouse position
	global_position = get_viewport().get_mouse_position()
