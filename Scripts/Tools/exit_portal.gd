extends Area2D


#region vars

@onready var transition_timer: Timer = $TransitionTimer

#endregion


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		Global.is_transitioning = true
		transition_timer.start()
		body.inactive = true


func _on_transition_timer_timeout() -> void:
	Global.completed_lvls.append(Global.level)
	Global.level = 0
	get_tree().change_scene_to_file("res://Scenes/WorldMap/world_map.tscn")
