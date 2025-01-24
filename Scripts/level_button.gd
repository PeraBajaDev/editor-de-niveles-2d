extends HBoxContainer


@export var play_mode_scene: PackedScene
@export var edit_mode_scene: PackedScene
@export var edit_name_input: LineEdit
@export var confirm_name: Button
signal edited()
func _ready() -> void:
	$LevelName.pressed.connect(play_level)
	$Edit.pressed.connect(edit_level)
	$Delete.pressed.connect(delete_level)
	$EditName.pressed.connect(show_edit_input)
func play_level():
	select_level()
	get_tree().change_scene_to_packed(play_mode_scene)

func edit_level():
	select_level()
	get_tree().change_scene_to_packed(edit_mode_scene)
func delete_level():
	select_level()
	LevelManager.dir.remove(LevelManager.level_selected_path)
	edited.emit()

func show_edit_input():
	edit_name_input.show()
	confirm_name.show()
	confirm_name.button_down.connect(edit_level_name)
	edit_name_input.text_submitted.connect(func(_text): edit_level_name())
func edit_level_name():
	select_level()
	var error = LevelManager.dir.rename(LevelManager.level_selected_path, "%s/%s.json" % [LevelManager.LEVELS_DIRECTORY, edit_name_input.text])
	print(error)
	$LevelName.text = edit_name_input.text
	edit_name_input.hide()
	confirm_name.hide()
func select_level():
	LevelManager.level_selected_path = "%s/%s.json" % [LevelManager.LEVELS_DIRECTORY, $LevelName.text]
