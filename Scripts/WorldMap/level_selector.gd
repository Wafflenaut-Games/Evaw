extends Area2D

#region vars

@onready var vaw: CharacterBody2D = $"../../WorldMap_Vaw"
@onready var ap: AnimatedSprite2D = $AnimatedSprite2D

var complete = false

@export var directions: Array[String]
@export var level: int = 0

#endregion


func _physics_process(_delta: float) -> void:
	set_vars()
	select_lvl()
	handle_anims()


func vaw_on() -> bool:
	if round(position) == round(vaw.position):
		return true
	else:
		return false


func set_vars() -> void:
	if vaw_on() and vaw.stopped == false:
		Global.world_map_dirs = directions
		vaw.velocity = Vector2.ZERO
		vaw.stopped = true


func select_lvl() -> void:
	if vaw_on() and (Input.is_action_just_pressed("sine") or Input.is_action_just_pressed("lume") or Input.is_action_just_pressed("jump")):
		if typeof(level) == TYPE_INT and level > 0:
			get_tree().change_scene_to_file("res://Scenes/Lvls/lvl_%s.tscn" % level)


func handle_anims() -> void:
	if complete:
		ap.play("complete")
	else:
		ap.play("incomplete")


func _on_body_exited(body: Node2D) -> void:
	if body == vaw:
		vaw.stopped = false
