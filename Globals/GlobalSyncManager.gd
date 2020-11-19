tool
extends Node

#exports
enum ACTIONS {disabled, red, yellow, green, blue, purple}
export var sync_time_total_duration = 10.0 setget _set_sync_time_total_duration
export var sync_subdiv_count = 500 setget _set_sync_subdiv_count
export var sync_cell_count = 5 setget _set_sync_cell_count

#variables
var sync_action_enables = [false, false, false, false, false, false]
var sync_subdiv_current = 0 setget _set_sync_subdiv_current
var sync_cell_enables = []  #for retaining orchestrator cell states between resets

var sync_subdiv_upper_limit_reached = 0 	#furthest subdiv reached by timer, not by dragging
var sync_cell_current = 0	#automatically calculated


func _ready():
	#connect signals
	GlobalSignalManager.connect("physics_state_changed", self, "_on_physics_state_changed")
	GlobalSignalManager.connect("physics_reset_button_pressed", self, "_on_physics_reset_button_pressed")
	
	_update_timer_wait_time()
	$SyncTimer.paused = true
 

func _process(delta):
	#handle pause/play inputs
	if Input.is_action_just_pressed("physics_start_stop"):
		if GlobalSceneManager.physics_state == GlobalSceneManager.PHYSICS_STATES.running:
			GlobalSceneManager.physics_state = GlobalSceneManager.PHYSICS_STATES.stopped
		elif GlobalSceneManager.physics_state == GlobalSceneManager.PHYSICS_STATES.stopped:
			GlobalSceneManager.physics_state = GlobalSceneManager.PHYSICS_STATES.running


func _update_timer_wait_time():
	if has_node("SyncTimer"):
		$SyncTimer.wait_time = float(sync_time_total_duration) / float(sync_subdiv_count)


func _update_sync_cell_current():
	var subdiv_per_cell = sync_subdiv_count / sync_cell_count
	self.sync_cell_current = int(sync_subdiv_current / subdiv_per_cell)


func _set_sync_time_total_duration(new_val):
	sync_time_total_duration = new_val
	_update_timer_wait_time()


func _set_sync_subdiv_count(new_val):
	sync_subdiv_count = new_val
	_update_timer_wait_time()
	_update_sync_cell_current()


func _set_sync_cell_count(new_val):
	sync_cell_count = new_val
	_update_sync_cell_current()


func _set_sync_subdiv_current(new_val):
	sync_subdiv_current = new_val
	_update_sync_cell_current()


func _on_physics_state_changed(new_physics_state):
	if new_physics_state == GlobalSceneManager.PHYSICS_STATES.running:
		$SyncTimer.paused = false
	elif new_physics_state == GlobalSceneManager.PHYSICS_STATES.stopped:
		$SyncTimer.paused = true


func _on_physics_reset_button_pressed():
	self.sync_subdiv_current = 0
	sync_subdiv_upper_limit_reached = 0


func _on_SyncTimer_timeout():
	if sync_subdiv_current < sync_subdiv_count - 1:
		self.sync_subdiv_current += 1
		
		if sync_subdiv_current > sync_subdiv_upper_limit_reached:
			sync_subdiv_upper_limit_reached = sync_subdiv_current
		
		GlobalSignalManager.emit_signal("sync_timer_timeout")
	else:
		GlobalSignalManager.emit_signal("physics_reset_button_pressed")
