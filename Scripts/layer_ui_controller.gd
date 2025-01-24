extends HBoxContainer

@export var tile_map_layer_container : TileMapLayerContainer 
@export var editor: Node2D
@export var play_mode_scene: PackedScene
@export var level_selector_scene_path := "res://Scenes/level_selector.tscn"

func _ready() -> void:
	tile_map_layer_container.layer_selected_changed.connect(change_layer_number)
	$Add.button_down.connect(tile_map_layer_container.add_layer)
	$Substract.button_down.connect(tile_map_layer_container.delete_layer)
	$NextLayer.button_down.connect(func(): tile_map_layer_container.layer_selected += 1)
	$PreviousLayer.button_down.connect(func(): tile_map_layer_container.layer_selected -= 1)
	$Save.button_down.connect(tile_map_layer_container.save_tilemap)
	$PlayLevel.button_down.connect(change_to_play_mode)
	$Load.button_down.connect(tile_map_layer_container.load_tilemap)
	$LevelSelectionMenu.button_down.connect(func(): get_tree().change_scene_to_file(level_selector_scene_path))
func change_layer_number():
	$LayerCount.text = "%s" % tile_map_layer_container.layer_selected

func change_to_play_mode():
	tile_map_layer_container.save_tilemap()
	get_tree().change_scene_to_packed(play_mode_scene)
