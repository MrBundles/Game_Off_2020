tool
extends Interacts
class_name Interactable

func _ready():
	#set interact type
	interact_type = INTERACT_TYPES.interactable
	_on_physics_state_changed(GlobalSceneManager.physics_state)


