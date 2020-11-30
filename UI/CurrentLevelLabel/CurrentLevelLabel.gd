extends Label

#references
onready var game_scenes = GlobalSceneManager.get_node("GameScenes")

func _ready():
	visible = GlobalSceneManager.get_node("GameScenes").current_level != 0
	text = "Days Until Launch: " + str(game_scenes.game_scene_array.size() - game_scenes.current_level + 1).pad_zeros(2)
