extends AnimatedSprite2D


@onready var vaw: CharacterBody2D = $"../.."


func _process(_delta: float) -> void:
	if Global.wave_indicator:
		visible = true
	else:
		visible = false
	
	if not vaw.sine_used:
		play("unused")
	else:
		play("used")
