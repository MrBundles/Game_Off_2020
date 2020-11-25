tool
extends Interactor
class_name Grabber


#variables
var body_entered_array = []
var body_connected_array = []


func _ready():
	initial_physics_mode = INTERACT_MODES.mode_rigid
	_grabber_modulate_update()


func _process(delta):
	if Engine.editor_hint:
		_grabber_modulate_update()
	
	if action_a_enable:
		$GrabberSprite.modulate = GlobalColorManager.action_color_array[action_a]
		
		for body in body_entered_array:
			var joint = PinJoint2D.new()
			$PinJoints.add_child(joint)
			joint.node_a = body.get_path()
			joint.node_b = get_path()
			
			body_entered_array.remove(body_entered_array.find(body))
			body_connected_array.append(body)
	else:
		$GrabberSprite.modulate = GlobalColorManager.action_color_array[GlobalSyncManager.ACTIONS.disabled]
		
		for body in body_connected_array:
			body_connected_array.remove(body_connected_array.find(body))
			body_entered_array.append(body)
			
		for joint in $PinJoints.get_children():
			joint.queue_free()


func _grabber_modulate_update():
	$GrabberCenterSprite.modulate = GlobalColorManager.action_color_array[action_a]


func _on_Area2D_body_entered(body):
	if body is Interactable and not body in body_entered_array and not body in body_connected_array:
		body_entered_array.append(body)
		print(body_entered_array)


func _on_Area2D_body_exited(body):
	body_connected_array.remove(body_connected_array.find(body))
	body_entered_array.remove(body_entered_array.find(body))
	print(body_entered_array)
