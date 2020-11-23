tool
extends Interactor
class_name Arm

#enums
enum ARM_TYPES {slide, rotate}

#exports
export(ARM_TYPES) var arm_type = ARM_TYPES.rotate
export var arm_length = 1

#constants
const MIN_ARM_LENGTH = 1
const MAX_ARM_LENGTH = 50

#variables
var single_arm_length = 64


func _ready():
	_arm_length_update()
	_arm_type_update()
	_conveyor_modulate_update()


func _process(delta):
	if Engine.editor_hint:
		_arm_length_update()
		_arm_type_update()
		_conveyor_modulate_update()


func _integrate_forces(state):
	if arm_type == ARM_TYPES.slide:
		if action_a_enable and not action_b_enable:
			apply_central_impulse(Vector2(0, -2000))
			
		if action_b_enable and not action_a_enable:
			apply_central_impulse(Vector2(0, 2000))
		
	if arm_type == ARM_TYPES.rotate:
		if action_a_enable and not action_b_enable:
			apply_torque_impulse(20000)
			
		if action_b_enable and not action_a_enable:
			apply_torque_impulse(-20000)


func _arm_length_update():
	$ArmSpriteA.texture.region.size.x = single_arm_length * clamp(arm_length, MIN_ARM_LENGTH, MAX_ARM_LENGTH)
	$ArmSpriteB.texture.region.size.x = single_arm_length * clamp(arm_length, MIN_ARM_LENGTH, MAX_ARM_LENGTH)
	$CollisionShape2D.shape.extents.x = $ArmSpriteA.texture.region.size.x / 2
	$JointSprite.position.x = -$ArmSpriteA.texture.region.size.x / 2
	$JointCenterSprite.position.x = -$ArmSpriteA.texture.region.size.x / 2
	$JointActionAIndicator.position.x = -$ArmSpriteA.texture.region.size.x / 2 - 10
	$JointActionBIndicator.position.x = -$ArmSpriteA.texture.region.size.x / 2 - 10


func _arm_type_update():
	$ActionAIndicator.visible = arm_type == ARM_TYPES.slide
	$ActionBIndicator.visible = arm_type == ARM_TYPES.slide
	$JointActionAIndicator.visible = arm_type == ARM_TYPES.rotate
	$JointActionBIndicator.visible = arm_type == ARM_TYPES.rotate
	$JointSprite.visible = arm_type == ARM_TYPES.rotate
	$JointCenterSprite.visible = arm_type == ARM_TYPES.rotate


func _conveyor_modulate_update():
	$ArmSpriteA.modulate = GlobalColorManager.action_color_array[action_a]
	$ArmSpriteB.modulate = GlobalColorManager.action_color_array[action_b]
	$ActionAIndicator.modulate = GlobalColorManager.action_color_array[action_a]
	$ActionBIndicator.modulate = GlobalColorManager.action_color_array[action_b]
	$JointActionAIndicator.modulate = GlobalColorManager.action_color_array[action_a]
	$JointActionBIndicator.modulate = GlobalColorManager.action_color_array[action_b]
	$JointSprite.modulate = GlobalColorManager.action_color_array[action_a]
	$JointCenterSprite.modulate = GlobalColorManager.action_color_array[action_b]
