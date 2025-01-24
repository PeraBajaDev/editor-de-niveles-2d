extends Node2D

@export var configured_tile_map_layer: PackedScene
func _ready() -> void:
	for layer_data in TileManager.get_tiles_from(LevelManager.get_selected_level_data()):
		var tile_placer := configured_tile_map_layer.instantiate() as TilePlacer
		tile_placer.load_cells(layer_data.used_cells, layer_data.used_tiles_atlas_coords)
		add_child(tile_placer)
