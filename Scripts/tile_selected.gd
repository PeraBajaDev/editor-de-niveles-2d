extends Button

@export var terrain_set_id: int = 0
@export var terrain_id: int = 0
func _ready() -> void:
	self.pressed.connect(func(): TileManager.tile_selected.emit(terrain_id,terrain_set_id)) 
