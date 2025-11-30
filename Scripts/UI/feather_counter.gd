extends Control


func _process(_delta: float) -> void:
	if Global.level == 0 or Global.paused:
		visible = true
		visible = true
	else:
		visible = false
		visible = false
