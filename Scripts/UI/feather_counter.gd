extends Label


func _process(_delta: float) -> void:
	text = "x" + str(Global.feathers_collected)
