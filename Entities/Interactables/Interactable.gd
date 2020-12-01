tool
extends Interacts
class_name Interactable

#exports
export(Texture) var icon
export(GlobalSyncManager.ACTIONS) var action = GlobalSyncManager.ACTIONS.disabled


func _ready():
	#connect signals
	connect("body_entered", self, "_on_body_entered")
	connect("load_sync_data", self, "_on_load_sync_data")
	
	initial_physics_mode = INTERACT_MODES.mode_rigid
	collision_layer = 0b11
	collision_mask = 0b11


func _process(delta):
	modulate = GlobalColorManager.action_color_array[action]
	
	if has_node("Collider"):
		sync_data = [global_position, rotation_degrees, linear_velocity, angular_velocity,
		visible,
		collision_layer,
		collision_mask
		]


func _on_load_sync_data(sync_subdiv):
	global_position = sync_array[sync_subdiv][0]
	rotation_degrees = sync_array[sync_subdiv][1]
	linear_velocity = sync_array[sync_subdiv][2]
	angular_velocity = sync_array[sync_subdiv][3]
	visible = sync_array[sync_subdiv][4]
	collision_layer = sync_array[sync_subdiv][5]
	collision_mask = sync_array[sync_subdiv][6]
