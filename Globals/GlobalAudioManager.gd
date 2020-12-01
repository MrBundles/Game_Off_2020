tool
extends Node


func _ready():
	#connect signals
	GlobalSignalManager.connect("volume_changed", self, "_on_volume_changed")
	GlobalSignalManager.connect("mute_changed", self, "_on_mute_changed")
	
	GlobalSignalManager.connect("sfx_level_select_press", self, "_on_sfx_level_select_press")
	GlobalSignalManager.connect("sfx_rewind_sound", self, "_on_sfx_rewind_sound")
	GlobalSignalManager.connect("sfx_ui_button_press", self, "_on_sfx_ui_button_press")
	GlobalSignalManager.connect("level_win", self, "_on_sfx_win_sound")


func _on_volume_changed(audio_bus, new_val):
	AudioServer.set_bus_volume_db(audio_bus, new_val)


func _on_mute_changed(audio_bus, new_val):
	AudioServer.set_bus_mute(audio_bus, new_val)


func _on_sfx_level_select_press():
	$LevelSelectPressASP.play()


func _on_sfx_rewind_sound():
	$RewindSoundASP.play()


func _on_sfx_ui_button_press():
	$UIButtonPressASP.play()


func _on_sfx_win_sound():
	$WinSoundASP.play()
