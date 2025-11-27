extends Node2D


#region vars

@export var connected_door: Node2D
@onready var unlit: Sprite2D = $Unlit
@onready var lit: Sprite2D = $Lit
@onready var sensor_activate: AudioStreamPlayer = $SensorActivate

var init_vol = 0

#endregion


func _ready() -> void:
	init_vol = sensor_activate.volume_db - 24


func _process(_delta: float) -> void:
	if Global.dying:
		unlit.visible = true
		lit.visible = false
	
	sensor_activate.volume_db = init_vol + Global.vol


func activate():
	if unlit.visible:
		connected_door.open()
		unlit.visible = false
		lit.visible = true
		sensor_activate.play()
