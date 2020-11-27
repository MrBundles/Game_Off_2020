tool
extends Interactor
class_name Arm

#enums
enum ARM_TYPES {slide, rotate}

#exports
export(ARM_TYPES) var arm_type = ARM_TYPES.rotate
export var arm_length = 1
export var arm_speed = 50
export var arm_slide_mult = 100
export var arm_slide_vector = Vector2.ZERO


#constants
const MIN_ARM_LENGTH = 1
const MAX_ARM_LENGTH = 50

#variables
var single_arm_length = 64
var arm_initial_position = global_position

#pid variables
var pid_sp = 0 #setpoint
var pid_pv = 0 #process value in RPM
var pid_out = 0 #output

var rotation_previous : float = global_rotation_degrees


func _ready():
	#connect signals
	$PID_Controller/IterationTimer.connect("timeout", self, "_on_iteration_timer_timeout")
	connect("load_sync_data", self, "_on_load_sync_data")
	
	$PID_Controller._on_start_timer()
	
	_arm_length_update()
	_arm_type_update()
	_conveyor_modulate_update()


func _process(delta):
	sync_data = [global_position, rotation_degrees, linear_velocity, angular_velocity]
	
	if Engine.editor_hint:
		_arm_length_update()
		_arm_type_update()
		_conveyor_modulate_update()


func _integrate_forces(state):
	if arm_type == ARM_TYPES.rotate:
		if action_a_enable and not action_b_enable:
			pid_sp = arm_speed
			
		elif action_b_enable and not action_a_enable:
			pid_sp = -arm_speed
			
		else:
			pid_sp = 0
		
		apply_torque_impulse(pid_out)


func _on_iteration_timer_timeout():
	#calculate pid_pv
	var deg_per_sec = (float(global_rotation_degrees) - float(rotation_previous)) / $PID_Controller/IterationTimer.wait_time
	var rev_per_min = deg_per_sec * (1.0/360.0) / (1.0/60.0)
	var pid_pv = rev_per_min
	$PVLabel.text = str(pid_pv)
	
	rotation_previous = global_rotation_degrees
#	if name == "Arm2":
#		print("deg per sec: " + str(deg_per_sec) + "     sp: " + str(pid_sp) + "     pv: " + str(pid_pv) + "     out: " + str(pid_out))
	pid_out = clamp($PID_Controller.calculate(pid_sp, pid_pv), -5000000, 5000000)
	$PID_Controller._on_start_timer()


func _on_load_sync_data(sync_subdiv):
	global_position = sync_array[sync_subdiv][0]
	rotation_degrees = sync_array[sync_subdiv][1]
	linear_velocity = sync_array[sync_subdiv][2]
	angular_velocity = sync_array[sync_subdiv][3]


func _arm_length_update():
	$ArmSpriteA.texture.region.size.x = single_arm_length * clamp(arm_length, MIN_ARM_LENGTH, MAX_ARM_LENGTH)
	$ArmSpriteA.position.x = single_arm_length * clamp(arm_length, MIN_ARM_LENGTH, MAX_ARM_LENGTH) / 2
	$ArmSpriteB.texture.region.size.x = single_arm_length * clamp(arm_length, MIN_ARM_LENGTH, MAX_ARM_LENGTH)
	$ArmSpriteB.position.x = single_arm_length * clamp(arm_length, MIN_ARM_LENGTH, MAX_ARM_LENGTH) / 2
	$CollisionShape2D.shape.extents.x = $ArmSpriteA.texture.region.size.x / 2
	$CollisionShape2D.position.x = single_arm_length * clamp(arm_length, MIN_ARM_LENGTH, MAX_ARM_LENGTH) / 2
	$ActionAIndicator.position.x = single_arm_length * clamp(arm_length, MIN_ARM_LENGTH, MAX_ARM_LENGTH) / 2
	$ActionBIndicator.position.x = single_arm_length * clamp(arm_length, MIN_ARM_LENGTH, MAX_ARM_LENGTH) / 2


func _arm_type_update():
	if arm_type == ARM_TYPES.slide:
		initial_physics_mode = INTERACT_MODES.mode_kinematic
	if arm_type == ARM_TYPES.rotate:
		initial_physics_mode = INTERACT_MODES.mode_rigid
	
	$ActionAIndicator.visible = arm_type == ARM_TYPES.slide
	$ActionBIndicator.visible = arm_type == ARM_TYPES.slide
	$JointActionAIndicator.visible = arm_type == ARM_TYPES.rotate
	$JointActionBIndicator.visible = arm_type == ARM_TYPES.rotate
	$JointSprite.visible = arm_type == ARM_TYPES.rotate
	$JointCenterSprite.visible = arm_type == ARM_TYPES.rotate


func _conveyor_modulate_update():
	$ArmSpriteA.modulate = GlobalColorManager.action_color_array[action_a]
	$ArmSpriteB.modulate = GlobalColorManager.action_color_array[action_b]
	$ActionAIndicator.modulate = GlobalColorManager.action_color_array[action_b]
	$ActionBIndicator.modulate = GlobalColorManager.action_color_array[action_a]
	$JointActionAIndicator.modulate = GlobalColorManager.action_color_array[action_a]
	$JointActionBIndicator.modulate = GlobalColorManager.action_color_array[action_b]
	$JointSprite.modulate = GlobalColorManager.action_color_array[action_a]
	$JointCenterSprite.modulate = GlobalColorManager.action_color_array[action_b]
