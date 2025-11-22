extends Sprite2D
@onready var apcrt = $AnimationPlayer
@onready var apworld = $"../Worldmap11/AnimationPlayer"

func playanims ():
	apworld.play("zoom2")
	apcrt.play("zoom")
	
