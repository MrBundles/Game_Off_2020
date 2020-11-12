extends RigidBody2D
class_name Interactable

#variables
var sync_array = []


func _ready():
	#connect signals
	GlobalSignalManager.connect("reset_scene", self, "_on_reset_scene")


func _physics_process(delta):
	var interactable_data = [position, rotation_degrees, linear_velocity, angular_velocity]
	sync_array.append(interactable_data)


func _on_reset_scene():
	print(sync_array)
	sync_array = []
