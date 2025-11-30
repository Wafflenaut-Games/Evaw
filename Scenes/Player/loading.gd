extends CanvasLayer


func _process(_delta: float) -> void:
	if $"../LevelTitles".visible == true:
		visible = false
