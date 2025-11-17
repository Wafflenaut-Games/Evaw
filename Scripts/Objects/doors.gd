extends StaticBody2D


#region vars

@onready var ap: AnimationPlayer = $AnimationPlayer
@onready var open_timer: Timer = $OpenTimer


var opened = false
var fully_open = false


@export var type: String = "sine"

#endregion


func _ready() -> void:
	if type == "sine":
		ap.play("sine_closed")
	if type == "lume":
		ap.play("lume_closed")


func _process(delta: float) -> void:
	# Reset when you die
	if Global.respawning:
		opened = false
		fully_open = false
		
		if type == "sine":
			ap.play("sine_closed")
		if type == "lume":
			ap.play("lume_closed")


func open() -> void:
	if not opened:
		opened = true
		match type:
			"sine":
				ap.play("sine_opening")
			"lume":
				ap.play("lume_opening")
		
		open_timer.start()


func _on_open_timer_timeout() -> void:
	fully_open = true
