extends Camera2D #whatever limits is does smt, but fade and the transition timer will be replaced by the reverse transition anim


#region vars

@onready var transition_timer: Timer = $TransitionTimer

var trans_timer_started = false

#endregion


func _process(_delta: float) -> void:
	fade()
	limits()
	
	if Global.level == 0:
		$Feather.visible = true
		$feather_counter.visible = true
	else:
		$Feather.visible = false
		$feather_counter.visible = false


func fade() -> void:
	if Global.is_transitioning == true:
		if not trans_timer_started:
			transition_timer.start()
			trans_timer_started = true


func _on_transition_timer_timeout() -> void:
	trans_timer_started = false


func limits():
	pass
#	if Global.level == 3:
#		limit_left = -64
#	if Global.level == 2:
#		limit_left = -55
