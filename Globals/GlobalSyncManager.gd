tool
extends Node

#exports
enum ACTIONS {disabled, red, yellow, green, blue, purple}
export var sync_timer_duration = 10

#variables
var sync_action_enables = [false, false, false, false, false, false]
var sync_index = 0 setget _set_sync_index
var cell_quantity = 1


func _ready():
	$SyncTimer.wait_time = sync_timer_duration


func _set_sync_index(new_val):
	sync_index = new_val
	

func _on_SyncTimer_timeout():
	if sync_index < cell_quantity - 1:
		sync_index += 1
	else:
		sync_index = 0
