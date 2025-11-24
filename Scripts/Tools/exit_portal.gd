extends Area2D


#region vars

@onready var light: PointLight2D = $PointLight2D
@onready var transitions: AnimatedSprite2D = $Transitions
@onready var transition_timer: Timer = $TransitionTimer
@onready var vaw: CharacterBody2D = $"../Vaw"

var entered = false

#endregion


func _process(_delta: float) -> void:
	leave()
	visibility()
	
	transitions.global_position = vaw.global_position


func leave() -> void:
	if vaw.is_grounded() and entered:
		Global.is_transitioning = true
		transitions.play("close")
		transition_timer.start()
		vaw.inactive = true
		Global.lvl_completed = Global.level


func visibility() -> void:
	if not Global.is_transitioning and not Global.paused:
		light.visible = true
	else:
		light.visible = false


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		entered = true


func _on_transition_timer_timeout() -> void:
	Global.completed_lvls.append(Global.level)
	Global.level = 0
	get_tree().change_scene_to_file("res://Scenes/WorldMap/world_map.tscn")


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		entered = false
