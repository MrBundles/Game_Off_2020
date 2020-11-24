tool
extends Interacts
class_name Interactor

#exports
export(GlobalSyncManager.ACTIONS) var action_a = GlobalSyncManager.ACTIONS.disabled
export(GlobalSyncManager.ACTIONS) var action_b = GlobalSyncManager.ACTIONS.disabled
export(NodePath) var interactor_parent = null

#variables
var action_a_enable : bool
var action_b_enable : bool
var interactor_tooltip_instance : Node


func _process(delta):
	action_a_enable = GlobalSyncManager.sync_action_enables[action_a]
	action_b_enable = GlobalSyncManager.sync_action_enables[action_b]
	
#	if GlobalSceneManager.physics_state == GlobalSceneManager.PHYSICS_STATES.running and initial_physics_mode == INTERACT_MODES.mode_rigid:
#		if (action_a_enable and not action_b_enable) or (action_b_enable and not action_a_enable):
#			mode = initial_physics_mode
#		else:
#			mode = RigidBody2D.MODE_KINEMATIC
