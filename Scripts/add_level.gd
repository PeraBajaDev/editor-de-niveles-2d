extends Button

@export var levels_container: VBoxContainer
@export var level_button_scene: PackedScene
@export var level_name_input: LineEdit
@export var confirm_name: Button
signal added
func _ready() -> void:
	button_down.connect(show_text_edit)
	
func show_text_edit():
	self.disabled = true
	level_name_input.show()
	confirm_name.show()
	confirm_name.button_down.connect(add_level)
	level_name_input.text_submitted.connect(func(_text): add_level())
	
func add_level():
	FileAccess.open('%s/%s.json' % [LevelManager.LEVELS_DIRECTORY, level_name_input.text],FileAccess.WRITE)
	added.emit()
	level_name_input.hide()
	confirm_name.hide()
	self.disabled = false
