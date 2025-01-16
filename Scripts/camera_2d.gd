extends Camera2D

@export var initial_movement_speed: int
@export var movement_speed_when_shifting : int
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var h_movement = Input.get_axis("ui_left", "ui_right")
	var v_movement = Input.get_axis("ui_up", "ui_down")
	var movement_speed = initial_movement_speed if not Input.is_action_pressed("level_editor_shifting") else movement_speed_when_shifting
	position.x = move_toward(position.x, position.x + h_movement * movement_speed, movement_speed * delta)
	position.y = move_toward(position.y, position.y + v_movement * movement_speed, movement_speed * delta)
