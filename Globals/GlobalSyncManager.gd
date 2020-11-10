tool
extends Node

#exports
enum ACTIONS {disabled, red, yellow, green, blue, purple}
export var sync_timer_duration = 10

#variables
var sync_action_enables = [false, false, false, false, false, false]
var sync_index = 0 setget _set_sync_index
var cell_quantity = 1
var sync_timer_start = false setget _set_sync_timer_start


func _ready():
	#connect signals
	GlobalSignalManager.connect("reset_scene", self, "_on_reset_scene")
	
	$SyncTimer.wait_time = sync_timer_duration


func _set_sync_index(new_val):
	sync_index = new_val


func _set_sync_timer_start(new_val):
	sync_timer_start = new_val
	
	if sync_timer_start:
		$SyncTimer.start()
	else:
		$SyncTimer.stop()


func _on_reset_scene():
	_set_sync_index(0)
	_set_sync_timer_start(false)


func _on_SyncTimer_timeout():
	if sync_index < cell_quantity - 1:
		sync_index += 1
	else:
		sync_index = 0
