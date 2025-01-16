extends AudioStreamPlayer2D

var tile_map: TilePlacer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	tile_map = get_parent()
	tile_map.tile_placed.connect(play_pop_sound)
	tile_map.tile_deleted.connect(play_destroy_sound)

func play_pop_sound(_atlas_coords, _coords):
	stream = preload("res://Sound FX/pop_up_sound.wav")
	play()

func play_destroy_sound():
	stream = preload("res://Sound FX/destroy_sound.wav")
	play()
