extends CanvasLayer

#enums
enum SCENE_TYPES {menu, game}

#exports
export(SCENE_TYPES) var scene_type = SCENE_TYPES.menu


func _ready():
	#connect signals
	GlobalSignalManager.connect("open_scene", self, "_on_open_scene")


func _on_open_scene(scene_instance_type, scene_instance_path):
	if scene_type == scene_instance_type:
		_clear_children()
		var scene_instance = load(scene_instance_path).instance()
		add_child(scene_instance)


func _clear_children():
	for child in get_children():
		child.queue_free()
