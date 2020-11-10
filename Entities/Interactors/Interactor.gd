tool
extends StaticBody2D
class_name Interactor

#signals
signal action_changed

#exports
export(GlobalSyncManager.ACTIONS) var action_a = GlobalSyncManager.ACTIONS.disabled
export(GlobalSyncManager.ACTIONS) var action_b = GlobalSyncManager.ACTIONS.disabled

#variables
var action_a_enable : bool
var action_b_enable : bool
var interactor_tooltip_instance : Node


func _process(delta):
	if not Engine.editor_hint:
		action_a_enable = GlobalSyncManager.sync_action_enables[action_a]
		action_b_enable = GlobalSyncManager.sync_action_enables[action_b]


func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == BUTTON_LEFT:
				if action_a < len(GlobalSyncManager.ACTIONS) - 1:
					action_a += 1
				else:
					action_a = 0
			if event.button_index == BUTTON_RIGHT:
				if action_b < len(GlobalSyncManager.ACTIONS) - 1:
					action_b += 1
				else:
					action_b = 0
			
			emit_signal("action_changed")
		

func _on_mouse_entered():
	interactor_tooltip_instance = preload("res://Entities/Interactors/InteractorTooltip.tscn").instance()
	add_child(interactor_tooltip_instance)
	

func _on_mouse_exited():
	for child in get_children():
		if "InteractorTooltip" in child.name:
			child.queue_free()
