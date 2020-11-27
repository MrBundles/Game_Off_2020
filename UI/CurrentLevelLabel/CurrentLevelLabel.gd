extends Label

func _ready():
	visible = GlobalSceneManager.get_node("GameScenes").current_level != 0
	text = "Level " + str(GlobalSceneManager.get_node("GameScenes").current_level).pad_zeros(2)
