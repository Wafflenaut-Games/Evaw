extends CanvasLayer


func _process(delta: float) -> void:
	if $"../LevelTitles".visible == true:
		visible = false
