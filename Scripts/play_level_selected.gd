extends Button

@export var play_mode_scene: PackedScene
func _ready() -> void:
	pressed.connect(play_level)

func play_level():
	LevelManager.level_selected_path = "%s/%s.json" % [LevelManager.LEVELS_DIRECTORY, text]
	get_tree().change_scene_to_packed(play_mode_scene)
