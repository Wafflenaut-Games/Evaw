extends CanvasLayer


func _process(_delta: float) -> void:
	if $"../Camera/TransitionsLayer/LevelTitles".visible == true:
		visible = false
