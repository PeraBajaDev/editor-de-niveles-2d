extends MarginContainer

@export var levels_container: VBoxContainer
@export var level_button_scene: PackedScene
@export var add_level: Button
func _ready() -> void:
	add_level.added.connect(reload_level_buttons)
	add_level_buttons()

func add_level_buttons():
	for level_name in LevelManager.get_levels_names():
		var level_button = level_button_scene.instantiate()
		level_button.get_child(0).text = level_name
		level_button.edited.connect(reload_level_buttons)
		levels_container.add_child(level_button)

func reload_level_buttons():
	for level_button in levels_container.get_children():
		level_button.queue_free()
	add_level_buttons()
	
