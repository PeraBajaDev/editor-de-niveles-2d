extends Node


signal tile_selected(terrain_id, terrain_set_id)

func get_tiles_from(data: Dictionary) -> Array[TileMapLayerData]:
	if not data: return [TileMapLayerData.new()]
	
	var tiles_map_data: Array[TileMapLayerData]
	for layer in data["layers"]:
		var formated_used_cells := layer["used_cells"] as Array
		var formated_used_tiles_atlas_coords := layer["used_tiles_atlas_coords"] as Array
		var layer_data = TileMapLayerData.new()
		layer_data.used_cells.assign(formated_used_cells.map(JSONParsing.parse_Vector2i))
		layer_data.used_tiles_atlas_coords.assign(formated_used_tiles_atlas_coords.map(JSONParsing.parse_Vector2i))
		tiles_map_data.append(layer_data)
	
	return tiles_map_data


	
