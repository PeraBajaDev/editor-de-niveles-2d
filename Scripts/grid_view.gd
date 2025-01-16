extends Node2D

const GRID_SIZE : int = 400
const CELL_SIZE : int = 16
func _draw() -> void:
	for coord in range(-GRID_SIZE, GRID_SIZE, CELL_SIZE):
		draw_line(Vector2(-GRID_SIZE, coord) , Vector2(GRID_SIZE, coord), Color.BLANCHED_ALMOND, 0.4, false)
		draw_line(Vector2(coord, -GRID_SIZE) , Vector2(coord, GRID_SIZE), Color.BLANCHED_ALMOND, 0.4, false)
		
