extends Button


func _process(_delta: float) -> void:
	match Global.wave_indicator:
		false:
			icon = load("res://Assets/Interactables/buttonpress.png")
		true:
			icon = load("res://Assets/Interactables/buttonpress-export.png")


func clicked() -> void:
	match Global.wave_indicator:
		true:
			Global.wave_indicator = false
			icon = load("res://Assets/Interactables/buttonpress.png")
		false:
			Global.wave_indicator = true
			icon = load("res://Assets/Interactables/buttonpress-export.png")
