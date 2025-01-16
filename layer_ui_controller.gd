extends HBoxContainer

@export var tile_map_layer_container : TileMapLayerContainer 
func _ready() -> void:
	tile_map_layer_container.layer_selected_changed.connect(change_layer_number)
	$Add.pressed.connect(tile_map_layer_container.add_layer)
	$Substract.pressed.connect(tile_map_layer_container.delete_layer)
	$NextLayer.pressed.connect(func(): tile_map_layer_container.layer_selected += 1)
	$PreviousLayer.pressed.connect(func(): tile_map_layer_container.layer_selected -= 1)
func change_layer_number():
	$LayerCount.text = "%s" % tile_map_layer_container.layer_selected
