tool
extends Interactor
class_name Conveyor

#exports
export var conveyor_speed = 50
export var conveyor_length = 1 setget _set_conveyor_length

#constants
const MIN_CONVEYOR_LENGTH = 1
const MAX_CONVEYOR_LENGTH = 50

#variables
var single_conveyor_length = 64


func _ready():
	#connect signals
	connect("load_sync_data", self, "_on_load_sync_data")
	
	initial_physics_mode = INTERACT_MODES.mode_kinematic
	_conveyor_modulate_update()

func _process(delta):
	sync_data = [global_position, rotation_degrees, linear_velocity, angular_velocity,
	$ConveyorSpriteA.texture.region.position.x,
	$ConveyorSpriteB.texture.region.position.x
	]
	if Engine.editor_hint:
		_conveyor_modulate_update()
	
	if action_a_enable and not action_b_enable and GlobalSceneManager.physics_state == GlobalSceneManager.PHYSICS_STATES.running:
		$ConveyorSpriteA.texture.region.position.x += conveyor_speed * delta
		$ConveyorSpriteB.texture.region.position.x += conveyor_speed * delta
		linear_velocity = Vector2(-conveyor_speed,0)
		
	elif action_b_enable and not action_a_enable and GlobalSceneManager.physics_state == GlobalSceneManager.PHYSICS_STATES.running:
		$ConveyorSpriteA.texture.region.position.x -= conveyor_speed * delta
		$ConveyorSpriteB.texture.region.position.x -= conveyor_speed * delta
		linear_velocity = Vector2(conveyor_speed,0)
		
	else:
		linear_velocity = Vector2(0,0)


func _on_load_sync_data(sync_subdiv):
	global_position = sync_array[sync_subdiv][0]
	rotation_degrees = sync_array[sync_subdiv][1]
	linear_velocity = sync_array[sync_subdiv][2]
	angular_velocity = sync_array[sync_subdiv][3]
	$ConveyorSpriteA.texture.region.position.x = sync_array[sync_subdiv][4]
	$ConveyorSpriteB.texture.region.position.x = sync_array[sync_subdiv][5]


func _set_conveyor_length(new_val):
	conveyor_length = new_val
	
	$ConveyorSpriteA.texture.region.size.x = single_conveyor_length * clamp(conveyor_length, MIN_CONVEYOR_LENGTH, MAX_CONVEYOR_LENGTH)
	$ConveyorSpriteB.texture.region.size.x = single_conveyor_length * clamp(conveyor_length, MIN_CONVEYOR_LENGTH, MAX_CONVEYOR_LENGTH)
	$CollisionShape2D.shape.extents.x = $ConveyorSpriteA.texture.region.size.x / 2


func _conveyor_modulate_update():
		$ConveyorSpriteA.modulate = GlobalColorManager.action_color_array[action_a]
		$ConveyorSpriteB.modulate = GlobalColorManager.action_color_array[action_b]
		$ActionAIndicator.modulate = GlobalColorManager.action_color_array[action_a]
		$ActionBIndicator.modulate = GlobalColorManager.action_color_array[action_b]




func _on_Conveyor_body_entered(body):
	$CollisionASP.play()
