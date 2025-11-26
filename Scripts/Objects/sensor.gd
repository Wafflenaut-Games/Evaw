extends Node2D


@export var connected_door: Node2D
@onready var unlit: Sprite2D = $Unlit
@onready var lit: Sprite2D = $Lit
@onready var sensor_activate: AudioStreamPlayer = $SensorActivate


func _process(_delta: float) -> void:
	if Global.dying:
		unlit.visible = true
		lit.visible = false


func activate():
	connected_door.open()
	unlit.visible = false
	lit.visible = true
	sensor_activate.play()
