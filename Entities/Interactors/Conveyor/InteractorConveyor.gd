tool
extends Interactor
class_name Conveyor

#exports
export var conveyor_speed = 50
export var conveyor_length = 1 setget _set_conveyor_length

#variables
var single_conveyor_length = 64
var min_conveyor_length = 1
var max_conveyor_length = 50


func _ready():
	#connect signals
	connect("action_changed", self, "_conveyor_modulate_update")
	
	_set_conveyor_length(conveyor_length)
	_conveyor_modulate_update()

func _process(delta):
	
	if action_a_enable and not action_b_enable:
		$ConveyorSpriteA.texture.region.position.x += conveyor_speed * delta
		$ConveyorSpriteB.texture.region.position.x += conveyor_speed * delta
		constant_linear_velocity = Vector2(-conveyor_speed,0)
		
	elif action_b_enable and not action_a_enable:
		$ConveyorSpriteA.texture.region.position.x -= conveyor_speed * delta
		$ConveyorSpriteB.texture.region.position.x -= conveyor_speed * delta
		constant_linear_velocity = Vector2(conveyor_speed,0)
		
	else:
		constant_linear_velocity = Vector2(0,0)


func _set_conveyor_length(new_val):
	conveyor_length = new_val
	
	$ConveyorSpriteA.texture.region.size.x = single_conveyor_length * clamp(conveyor_length, min_conveyor_length, max_conveyor_length)
	$ConveyorSpriteB.texture.region.size.x = single_conveyor_length * clamp(conveyor_length, min_conveyor_length, max_conveyor_length)
	$CollisionShape2D.shape.extents.x = $ConveyorSpriteA.texture.region.size.x / 2


func _conveyor_modulate_update():
	#modulate conveyors
	$ConveyorSpriteA.modulate = GlobalColorManager.action_color_array[action_a]
	$ConveyorSpriteB.modulate = GlobalColorManager.action_color_array[action_b]
	
	$ActionAIndicator.modulate = GlobalColorManager.action_color_array[action_a]
	$ActionBIndicator.modulate = GlobalColorManager.action_color_array[action_b]


