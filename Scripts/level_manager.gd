extends Node

const LEVELS_DIRECTORY = "user://levels"
var level_selected_path: String = LEVELS_DIRECTORY + "/level1.json"
var dir: DirAccess

func _ready() -> void:
	dir = DirAccess.open("user://")
	if not dir.dir_exists("levels"):
		dir.make_dir(LEVELS_DIRECTORY)
	
func get_levels_names() -> Array[String]:
	
	var levels_path: PackedStringArray = DirAccess.get_files_at(LEVELS_DIRECTORY)
	var level_names: Array[String]
	for level_path in levels_path:
		level_names.append(level_path.replace(".json", ""))
	return level_names
	
func get_selected_level_data() -> Dictionary:
	var file = FileAccess.open(level_selected_path, FileAccess.READ)
	if not file:
		printerr("No existe el nivel en la ruta: " + level_selected_path)
		return {}
	var data = JSON.parse_string(file.get_as_text())
	if not data: return {}
	
	return data
