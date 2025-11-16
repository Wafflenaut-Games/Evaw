extends StaticBody2D


#region vars

@onready var ap: AnimationPlayer = $AnimationPlayer
@onready var open_timer: Timer = $OpenTimer


var opened = false
var fully_open = false


@export var type: String = "Sine"

#endregion


func _process(_delta: float) -> void:
	still_anims()


func still_anims() -> void:
	if not opened:
		ap.play("%sclosed" % type.to_lower() + "_")
	elif opened and fully_open:
		ap.play("open")


func open() -> void:
	if not opened:
		opened = true
		ap.play("%sopening" % type.to_lower() + "_")
		open_timer.start()


func _on_open_timer_timeout() -> void:
	fully_open = true
