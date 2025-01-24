class_name TilePlacer
extends TileMapLayer

var selected_terrain_set : int = 0
var selected_terrain : int = 0 
var used_cell_coords: Array[Vector2i]
signal tile_placed(atlas_coords: Vector2i, coords: Vector2i)

signal tile_deleted()
func _ready() -> void:
	TileManager.tile_selected.connect(change_selected_tile)

func place_tile() -> void:
	var mouse_position = get_mouse_position()
	if tile_same_as_selected(mouse_position): return
	set_cells_terrain_connect([mouse_position], selected_terrain_set, selected_terrain, false)
	
	tile_placed.emit(get_cell_atlas_coords(mouse_position), map_to_local(mouse_position))
func delete_tile():
	var mouse_position = get_mouse_position()
	if not has_tile(mouse_position): return
	erase_cell(mouse_position) 
	
	tile_deleted.emit()

func get_mouse_position() -> Vector2i:
	return local_to_map(self.get_local_mouse_position()) as Vector2i

func change_selected_tile(selected_terrain_id, terrain_set: int):
	selected_terrain_set = terrain_set
	selected_terrain = selected_terrain_id 

func has_tile(coords: Vector2i) -> bool:
	return get_cell_tile_data(coords) != null

func tile_same_as_selected(mouse_position) -> bool:
	var tile = get_cell_tile_data(mouse_position)
	if not tile: return false
	
	return tile.terrain == selected_terrain and tile.terrain_set == selected_terrain_set
	
func get_used_tiles_atlas_coords(used_cells: Array[Vector2i]) -> Array:
	return used_cells.map(func(coord): return get_cell_atlas_coords(coord))
	
func load_cells(used_cells: Array[Vector2i], used_tiles_atlas_coords: Array[Vector2i]):
	if not used_cells or not used_tiles_atlas_coords:
		return
	
	for i in range(used_cells.size()):
		set_cell(used_cells[i], 0, used_tiles_atlas_coords[i])
