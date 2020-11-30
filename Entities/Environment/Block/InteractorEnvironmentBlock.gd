tool
extends StaticBody2D

#exports
export(GlobalSyncManager.ACTIONS) var action = GlobalSyncManager.ACTIONS.disabled setget _set_action
export var width = 1 setget _set_width
export var height = 1 setget _set_height

#variables
var block_size = Vector2(16,16)

func _ready():
	_set_width(width)
	_set_height(height)


func _set_action(new_val):
	action = new_val
	modulate = GlobalColorManager.action_color_array[action]


func _set_width(new_val):
	width = new_val
	
	$Sprite.scale.x = width
	$CollisionShape2D.shape.extents.x = block_size.x * width


func _set_height(new_val):
	height = new_val
	
	$Sprite.scale.y = height
	$CollisionShape2D.shape.extents.y = block_size.y * height

