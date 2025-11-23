extends AnimatedSprite2D


@onready var parent = $"../"


func _process(_delta: float) -> void:
	if parent.interactable == true and parent.interacting == false:
		visible = true
		play("interactable")
	elif parent.interactable == true and parent.interacting == true:
		visible = true
		play("pressed")
	else:
		visible = false
