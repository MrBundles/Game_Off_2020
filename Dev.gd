extends Node2D


func _process(delta):
	$Label.text = "box type: " + str($Box.interact_type) + "    conveyor type: " + str($Conveyor.interact_type)
