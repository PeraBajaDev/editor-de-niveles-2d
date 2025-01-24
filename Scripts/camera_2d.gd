extends Camera2D

@export var initial_movement_speed: int
@export var movement_speed_when_shifting : int 
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var h_movement = Input.get_axis("ui_left", "ui_right")
	var v_movement = Input.get_axis("ui_up", "ui_down")
	var movement_speed = initial_movement_speed if not Input.is_action_pressed("level_editor_shifting") else movement_speed_when_shifting
	position.x = move_toward(position.x, position.x + h_movement * movement_speed, movement_speed * delta)
	position.y = move_toward(position.y, position.y + v_movement * movement_speed, movement_speed * delta)

func _unhandled_input(event: InputEvent) -> void:
	
	if event.is_action_pressed("zoom_in"):
		var zoom_tweener := get_tree().create_tween()
		zoom_tweener.tween_property(self, "zoom", zoom + Vector2.ONE * 0.2, 0.3).set_ease(Tween.EASE_IN_OUT)
	if event.is_action_pressed("zoom_out"):
		var zoom_tweener := get_tree().create_tween()
		zoom_tweener.tween_property(self, "zoom", zoom - Vector2.ONE * 0.2, 0.3).set_ease(Tween.EASE_IN_OUT)
