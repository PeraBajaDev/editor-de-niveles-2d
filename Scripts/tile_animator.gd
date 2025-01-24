extends Node

@export var tileset_texture: Texture2D
@onready var tile_map: TilePlacer = get_parent()
func _ready() -> void:
	tile_map.tile_placed.connect(animate)
	

func animate(atlas_coords: Vector2i, coords: Vector2i):
	var sprite = Sprite2D.new()
	sprite.texture = tileset_texture
	sprite.hframes = 17
	sprite.vframes = 8
	sprite.frame_coords = atlas_coords
	sprite.position = coords
	sprite.scale *= 0.7 
	tile_map.add_child(sprite)
	var tween = create_tween()
	tween.tween_property(sprite, "scale", Vector2.ONE * 1.5, 0.2).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	await tween.finished
	sprite.queue_free()
