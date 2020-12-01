extends Label

#references
onready var game_scenes = GlobalSceneManager.get_node("GameScenes")

func _ready():
	text = "Days Until Launch: " + str(game_scenes.game_scene_array.size() - game_scenes.current_level).pad_zeros(2)
