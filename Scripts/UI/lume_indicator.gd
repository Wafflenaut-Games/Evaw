extends AnimatedSprite2D


@onready var vaw: CharacterBody2D = $"../.."


func _process(_delta: float) -> void:
	if not vaw.lume_used:
		play("sine")
	else:
		play("used")
