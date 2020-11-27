tool
extends Interactor

#exports
export(PackedScene) var interactable_type
export var required_qty = 10


func _ready():
	#connect signals
	connect("load_sync_data", self, "_on_load_sync_data")
	
	$InteractableIcon.texture = interactable_type.instance().icon



func _process(delta):
	sync_data = [global_position, rotation_degrees, linear_velocity, angular_velocity,
	required_qty
	]
	
	$InteractableIcon.modulate = GlobalColorManager.action_color_array[action_a]
	$Label.text = "x " + str(required_qty)


func _on_load_sync_data(sync_subdiv):
	global_position = sync_array[sync_subdiv][0]
	rotation_degrees = sync_array[sync_subdiv][1]
	linear_velocity = sync_array[sync_subdiv][2]
	angular_velocity = sync_array[sync_subdiv][3]
	required_qty = sync_array[sync_subdiv][4]


func _on_Area2D_body_entered(body):
	if not "Hatch" in body.name and body is Interactable:
		body.hide()
		body.collision_layer = 0b0
		
		if body.action == action_a:
			if "Box" in interactable_type.instance().name and "Box" in body.name:
				_decrement_required_qty()
			elif "Triangle" in interactable_type.instance().name and "Triangle" in body.name:
				_decrement_required_qty()
			elif "Circle" in interactable_type.instance().name and "Circle" in body.name:
				_decrement_required_qty()


func _decrement_required_qty():
	if required_qty > 0:
		required_qty -= 1
