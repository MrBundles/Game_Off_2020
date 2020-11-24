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
export var arm_rotate_mult = 500


#constants
const MIN_ARM_LENGTH = 1
const MAX_ARM_LENGTH = 50

#variables
var single_arm_length = 64
var arm_initial_position = global_position


func _ready():
	_arm_length_update()
	_arm_type_update()
	_conveyor_modulate_update()


func _process(delta):
	if Engine.editor_hint:
		_arm_length_update()
		_arm_type_update()
		_conveyor_modulate_update()


func _physics_process(delta):
	if arm_type == ARM_TYPES.slide:
		if action_a_enable and not action_b_enable:
			apply_central_impulse(Vector2(0, -arm_speed * arm_slide_mult))
			
		if action_b_enable and not action_a_enable:
			apply_central_impulse(Vector2(0, arm_speed * arm_slide_mult))


func _integrate_forces(state):
	if arm_type == ARM_TYPES.rotate:
		if action_a_enable and not action_b_enable:
			apply_torque_impulse(arm_speed * arm_rotate_mult)
			
		if action_b_enable and not action_a_enable:
			apply_torque_impulse(-arm_speed * arm_rotate_mult)

func _draw():
	if arm_type == ARM_TYPES.slide:
		draw_line(Vector2(single_arm_length * clamp(arm_length, MIN_ARM_LENGTH, MAX_ARM_LENGTH) / 2, 0), arm_initial_position + arm_slide_vector, Color(0,0,0,1), 16.0)


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
