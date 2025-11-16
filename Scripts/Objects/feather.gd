extends Node2D


@export var level: int = 1

var collecting = false

var player


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if collecting == true:
		global_position = global_position.move_toward(player.global_position, 50 * delta)

func collect(body):
	player = body
	collecting = true
