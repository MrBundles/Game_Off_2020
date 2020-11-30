tool
extends Label

func _ready():
	var format_string = """The rocket is scheduled to launch in %s days
						And YOU have the most important job of all"""
	text = format_string % str(GlobalSceneManager.get_node("GameScenes").game_scene_array.size())
