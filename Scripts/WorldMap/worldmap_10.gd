extends Sprite2D

@onready var apcrt: AnimationPlayer = $apcrt
@onready var apworld: AnimationPlayer = $"../WorldMap/apworld"


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact"):
		playanims()


func playanims():
	apworld.play("zoom 2")
	apcrt.play("zoom")
