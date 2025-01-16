class_name TileMapLayerContainer
extends Node2D

signal layer_selected_changed()

var tile_map_layers: Array[TilePlacer]
var layer_selected: int: 
	set(value):
		if value < 0 or value >= tile_map_layers.size(): return
		
		layer_selected = value 
		layer_selected_changed.emit()

func _ready() -> void:
	tile_map_layers.assign(get_children())
	layer_selected_changed.connect(modulate_layers)

func _process(delta: float) -> void:
	if Input.is_action_pressed("level_editor_place_tile"):
		tile_map_layers[layer_selected].place_tile()
	if Input.is_action_pressed("level_editor_eliminate_tile"):
		tile_map_layers[layer_selected].delete_tile()

func add_layer():
	var tile_map_layer := tile_map_layers[layer_selected].duplicate() as TilePlacer
	tile_map_layer.clear()
	add_child(tile_map_layer)
	tile_map_layers.append(tile_map_layer)
	
func delete_layer():
	if tile_map_layers.size() <= 1: return 
	var tile_map_layer := tile_map_layers.pop_back() as Node2D
	layer_selected = tile_map_layers.size() - 1
	tile_map_layer.queue_free()

func modulate_layers():
	for layer in tile_map_layers:
		layer.modulate.a = 0
	var previous_layer = layer_selected - 1
	var next_layer = layer_selected + 1
	tile_map_layers[layer_selected].modulate. a = 1
	if previous_layer >= 0:
		tile_map_layers[previous_layer].modulate.a = 0.5
	if next_layer < tile_map_layers.size():
		tile_map_layers[next_layer].modulate.a = 0.5
