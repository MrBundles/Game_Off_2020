tool
extends Node

#exports
enum ACTIONS {disabled, red, yellow, green, blue, purple}
export var sync_timer_duration = 10

#variables
var sync_action_enables = [false, false, false, false, false, false]
var sync_timer_current_time = 0
var sync_timer_percent_elapsed : float = 0.0


func _ready():
	$SyncTimer.wait_time = sync_timer_duration


func _process(delta):
	sync_timer_duration = $SyncTimer.wait_time
	sync_timer_current_time = $SyncTimer.wait_time - $SyncTimer.time_left
	sync_timer_percent_elapsed = sync_timer_current_time / sync_timer_duration


func _on_SyncTimer_timeout():
	pass # Replace with function body.
