extends CanvasLayer

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		visible = not visible

func _on_start_button_button_down() -> void:
	visible = false

func _on_quit_button_button_down() -> void:
	get_tree().quit()
