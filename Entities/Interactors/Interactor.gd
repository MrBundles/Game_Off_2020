tool
extends Interacts
class_name Interactor

#exports
export(GlobalSyncManager.ACTIONS) var action_a = GlobalSyncManager.ACTIONS.disabled
export(GlobalSyncManager.ACTIONS) var action_b = GlobalSyncManager.ACTIONS.disabled
export(NodePath) var interactor_parent = null
export var action_a_force = false
export var action_b_force = false

#variables
var action_a_enable : bool
var action_b_enable : bool
var interactor_tooltip_instance : Node


func _process(delta):
	action_a_enable = GlobalSyncManager.sync_action_enables[action_a] or action_a_force
	action_b_enable = GlobalSyncManager.sync_action_enables[action_b] or action_b_force
