tool
extends HBoxContainer

#enums
enum AUDIO_BUSES {bus_master, bus_music, bus_effects}

#exports
export(AUDIO_BUSES) var audio_bus
export var label = "Volume: "


func _ready():
	$VolumeHSlider.value = AudioServer.get_bus_volume_db(audio_bus)
	$MuteButton.pressed = AudioServer.is_bus_mute(audio_bus)
	$VolumeLabel.text = label


func _process(delta):
	if $MuteButton.pressed:
		$MuteButton.text = "Unmute"
	else:
		$MuteButton.text = "Mute"


func _on_VolumeHSlider_value_changed(value):
	GlobalSignalManager.emit_signal("volume_changed", audio_bus, value)


func _on_MuteButton_pressed():
	GlobalSignalManager.emit_signal("mute_changed", audio_bus, $MuteButton.pressed)
