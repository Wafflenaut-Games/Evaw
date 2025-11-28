extends AnimatedSprite2D


@onready var vaw: CharacterBody2D = $"../.."


func _process(_delta: float) -> void:
	if Global.difficulty == 0:
		if not vaw.sine_used:
			play("unused")
		else:
			play("used")
