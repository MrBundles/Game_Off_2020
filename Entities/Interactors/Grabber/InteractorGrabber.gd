tool
extends Interactor
class_name Grabber


#variables
var body_entered_array = []
var joint_names = []


func _ready():
	#connect signals
	connect("load_sync_data", self, "_on_load_sync_data")
	
	initial_physics_mode = INTERACT_MODES.mode_rigid
	_grabber_modulate_update()


func _process(delta):
	sync_data = [global_position, rotation_degrees, linear_velocity, angular_velocity]
	
	if Engine.editor_hint:
		_grabber_modulate_update()
	
	if action_a_enable and GlobalSceneManager.physics_state == GlobalSceneManager.PHYSICS_STATES.running:
		$GrabberSprite.modulate = GlobalColorManager.action_color_array[action_a]
		
		for body in body_entered_array:
			if not body.name in joint_names:
				var joint = PinJoint2D.new()
				$PinJoints.add_child(joint)
				joint.node_a = body.get_path()
				joint.node_b = get_path()
				joint.name = body.name
				joint_names.append(joint.name)
			
	else:
		$GrabberSprite.modulate = GlobalColorManager.action_color_array[GlobalSyncManager.ACTIONS.disabled]
		
		for joint in $PinJoints.get_children():
			joint.queue_free()
		
		joint_names = []


func _on_load_sync_data(sync_subdiv):
	global_position = sync_array[sync_subdiv][0]
	rotation_degrees = sync_array[sync_subdiv][1]
	linear_velocity = sync_array[sync_subdiv][2]
	angular_velocity = sync_array[sync_subdiv][3]


func _grabber_modulate_update():
	$GrabberCenterSprite.modulate = GlobalColorManager.action_color_array[action_a]


func _on_Area2D_body_entered(body):
	if body is Interactable and not body in body_entered_array:
		body_entered_array.append(body)
		print(body_entered_array)


func _on_Area2D_body_exited(body):
	body_entered_array.remove(body_entered_array.find(body))
	print(body_entered_array)
