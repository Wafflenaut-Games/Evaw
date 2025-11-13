extends Area2D


@onready var vaw: CharacterBody2D = $"../../WorldMap_Vaw"

var complete = false

@export var directions: Array[String]
@export var level: int = 0

func _physics_process(_delta: float) -> void:
	set_vars()


func set_vars() -> void:
	if round(position) == round(vaw.position) and vaw.stopped == false:
		Global.world_map_dirs = directions
		vaw.velocity = Vector2.ZERO
		vaw.stopped = true


func _on_body_exited(body: Node2D) -> void:
	if body == vaw:
		vaw.stopped = false
