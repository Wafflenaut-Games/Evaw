extends HBoxContainer


signal clicked


func _on_checkbox_pressed() -> void:
	$checkbox.clicked()
	emit_signal("clicked")
