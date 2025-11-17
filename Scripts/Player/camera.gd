extends Camera2D


#region vars

@onready var ap: AnimationPlayer = $AnimationPlayer
@onready var transition_timer: Timer = $TransitionTimer

var trans_timer_started = false

#endregion


func _process(_delta: float) -> void:
	fade()
	
	limits()


func fade() -> void:
	if Global.is_transitioning == true:
		ap.play("fade_in")
		if not trans_timer_started:
			transition_timer.start()
			trans_timer_started = true


func _on_transition_timer_timeout() -> void:
	ap.stop(false)
	Global.is_transitioning = false
	trans_timer_started = false


func limits():
	if Global.level == 3:
		limit_left = -64
