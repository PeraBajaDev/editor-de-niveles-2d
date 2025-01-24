class_name TileMapLayerContainer
extends Node2D

signal layer_selected_changed()
@export var configured_tile_map_layer_scene: PackedScene
enum mouse_states {
	DEFAULT,
	PLACING,
	DELETING
}

var mouse_state := mouse_states.DEFAULT
var tile_map_layers: Array[TilePlacer]
var layer_selected: int: 
	set(value):
		if value < 0 or value >= tile_map_layers.size(): return
		
		layer_selected = value 
		layer_selected_changed.emit()

func _ready() -> void:
	tile_map_layers.assign(get_children())
	layer_selected_changed.connect(modulate_layers)
	load_tilemap()
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("level_editor_place_tile"):
		mouse_state = mouse_states.PLACING
	elif event.is_action_pressed("level_editor_eliminate_tile"):
		mouse_state = mouse_states.DELETING
	elif event.is_action_released("level_editor_place_tile"):
		mouse_state = mouse_states.DEFAULT
	elif event.is_action_released("level_editor_eliminate_tile"):
		mouse_state = mouse_states.DEFAULT

func _process(_delta: float) -> void:
	match mouse_state:
		mouse_states.DEFAULT:
			pass
		mouse_states.PLACING:
			tile_map_layers[layer_selected].place_tile()
		mouse_states.DELETING:
			tile_map_layers[layer_selected].delete_tile()

func add_layer():
	var tile_map_layer := configured_tile_map_layer_scene.instantiate() as TilePlacer
	add_child(tile_map_layer)
	tile_map_layers.append(tile_map_layer)
	
func delete_layer():
	if tile_map_layers.size() <= 1: return 
	var tile_map_layer := tile_map_layers.pop_back() as Node2D
	layer_selected = tile_map_layers.size() - 1
	tile_map_layer.queue_free()

func modulate_layers():
	if not tile_map_layers: return
	for layer in tile_map_layers:
		layer.modulate.a = 0
	var previous_layer = layer_selected - 1
	var next_layer = layer_selected + 1
	tile_map_layers[layer_selected].modulate. a = 1
	if previous_layer >= 0:
		tile_map_layers[previous_layer].modulate.a = 0.5
	if next_layer < tile_map_layers.size():
		tile_map_layers[next_layer].modulate.a = 0.5

func duplicate_layers_in_level(level: Node2D):
	for layer in tile_map_layers:
		layer.modulate.a = 1
		level.add_child(layer.duplicate())

func save_tilemap():
	var data := { "layers": [] }
	for layer in tile_map_layers:
		
		var used_cells := layer.get_used_cells() 
		var used_tiles_atlas_coords = layer.get_used_tiles_atlas_coords(used_cells)
		var formated_used_cells : Array = used_cells.map(JSONParsing.stringify_Vector2)
		var formated_used_tile_atlas_coords : Array = used_tiles_atlas_coords.map(JSONParsing.stringify_Vector2)
		data["layers"].append({
			"used_cells": formated_used_cells,
			"used_tiles_atlas_coords": formated_used_tile_atlas_coords
			})
	
	var file = FileAccess.open(LevelManager.level_selected_path, FileAccess.WRITE)
	file.store_string(JSON.stringify(data, "\t"))

func load_tilemap():
	for layer in tile_map_layers:
		layer.queue_free()
	tile_map_layers.clear()
	for layer_data in TileManager.get_tiles_from(LevelManager.get_selected_level_data()):
		add_layer()
		tile_map_layers[-1].load_cells(layer_data.used_cells, layer_data.used_tiles_atlas_coords)
	modulate_layers()
