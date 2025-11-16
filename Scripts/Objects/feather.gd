extends Node2D

#JAMES READ THIS BASICALLY YOU GOTTA MAKE FEATHER SPEED CHANGE WITH DIFFERENT WAVE FORMS
#AND FINISH THE LEVEL DISPLAY IN THE WORLDMAP AND MAKE THE FEATHERS RESET WHEN YOU DIE


@export var level: int = 1

var starting_pos: Vector2

var collecting = false

var speed = randf_range(30,70)

var player


func _ready() -> void:
	starting_pos = global_position


func _process(delta: float) -> void:
	if collecting == true:
		global_position = global_position.move_toward(player.global_position, speed * delta)

func collect(body):
	player = body
	collecting = true
