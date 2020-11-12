tool
extends Interactor
class_name Arm


func _integrate_forces(state):
	
	if action_a_enable and not action_b_enable:
		apply_torque_impulse(10000)
		
	elif action_b_enable and not action_a_enable:
		apply_torque_impulse(-10000)
		
	else:
		pass