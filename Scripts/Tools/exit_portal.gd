extends Area2D


#region vars

@onready var light: PointLight2D = $PointLight2D
@onready var transitions: AnimatedSprite2D = $Transitions
@onready var transition_timer: Timer = $TransitionTimer
@onready var vaw: CharacterBody2D = $"../Vaw"

#endregion


func _process(_delta: float) -> void:
	if not Global.is_transitioning and not Global.paused:
		light.visible = true
	else:
		light.visible = false
	
	transitions.global_position = vaw.global_position


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and body.is_grounded():
		Global.is_transitioning = true
		transitions.play("close")
		transition_timer.start()
		body.inactive = true
		Global.lvl_completed = Global.level


func _on_transition_timer_timeout() -> void:
	Global.completed_lvls.append(Global.level)
	Global.level = 0
	get_tree().change_scene_to_file("res://Scenes/WorldMap/world_map.tscn")
