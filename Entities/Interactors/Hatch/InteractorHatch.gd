tool
extends Interactor

#exports
export(PackedScene) var interactable_type
export var required_qty = 10
export var rotation_val = 0 setget _set_rotation_val


#variables
var consumed_interactable_array = []


func _ready():
	#connect signals
	connect("load_sync_data", self, "_on_load_sync_data")
	
	$InteractableIcon.texture = interactable_type.instance().icon


func _process(delta):
	sync_data = [global_position, rotation_degrees, linear_velocity, angular_velocity,
	required_qty,
	consumed_interactable_array.duplicate()
	]
	
	$InteractableIcon.modulate = GlobalColorManager.action_color_array[action_a]
	$Label.text = "x " + str(required_qty)


func _set_rotation_val(new_val):
	rotation_val = new_val
	$CollisionPolygon2D.rotation_degrees = rotation_val
	$Sprite.rotation_degrees = rotation_val
	$Area2D.rotation_degrees = rotation_val


func _on_load_sync_data(sync_subdiv):
	global_position = sync_array[sync_subdiv][0]
	rotation_degrees = sync_array[sync_subdiv][1]
	linear_velocity = sync_array[sync_subdiv][2]
	angular_velocity = sync_array[sync_subdiv][3]
	required_qty = sync_array[sync_subdiv][4]
	consumed_interactable_array = sync_array[sync_subdiv][5].duplicate()


func _on_Area2D_body_entered(body):
	if not "Hatch" in body.name and body is Interactable and not body in consumed_interactable_array:
		body.hide()
		body.collision_mask = 0b0
		body.collision_layer = 0b0
		
		if body.action == action_a:
			if "Box" in interactable_type.instance().name and "Box" in body.name:
				_decrement_required_qty(body)
			elif "Triangle" in interactable_type.instance().name and "Triangle" in body.name:
				_decrement_required_qty(body)
			elif "Circle" in interactable_type.instance().name and "Circle" in body.name:
				_decrement_required_qty(body)


func _decrement_required_qty(body):
	if required_qty > 0:
		required_qty -= 1
	if not body in consumed_interactable_array:
		consumed_interactable_array.append(body)
