extends Camera2D


#region vars

@onready var transition_timer: Timer = $TransitionTimer

var trans_timer_started = false

var randomShakeStrength: float = 3
var shakeFade: float = 15
var rng = RandomNumberGenerator.new()
var shake_strength: float = 0
var shake = false
var shake_timer_started = false
@onready var shake_timer: Timer = $shake_timer

#endregion


func _process(_delta: float) -> void:
	fade()
	screen_shake(_delta)


func fade() -> void:
	if Global.is_transitioning == true:
		if not trans_timer_started:
			transition_timer.start()
			trans_timer_started = true


func _on_transition_timer_timeout() -> void:
	trans_timer_started = false


func screen_shake(delta) -> void:
	if shake == true:
		shake_strength = randomShakeStrength
		if shake_timer_started == false:
			shake_timer.start()
			shake_timer_started = true
	if shake_strength > 0:
		shake_strength = lerpf(shake_strength, 0, shakeFade * delta)
		offset = Vector2(rng.randf_range(-shake_strength, shake_strength), rng.randf_range(-shake_strength, shake_strength))


func _on_shake_timer_timeout() -> void:
	shake = false
