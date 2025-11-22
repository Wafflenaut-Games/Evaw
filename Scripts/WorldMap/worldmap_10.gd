extends Sprite2D

@onready var apcrt: AnimationPlayer = $apcrt
@onready var apworld: AnimationPlayer = $"../Worldmap11/apworld"



func _ready() -> void:
	playanims()


func playanims ():
	apworld.play("zoom2")
	apcrt.play("zoom")
	
