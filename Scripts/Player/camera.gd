extends Camera2D


@onready var ap: AnimationPlayer = $AnimationPlayer

var transitioning = false


func _process(_delta: float) -> void:
	fade()


func fade() -> void:
	if transitioning == true:
		ap.play("fade_in")
		transitioning = false
