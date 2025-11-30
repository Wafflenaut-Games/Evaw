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
	if Global.respawning:
		unlit.visible = true
		lit.visible = false
	elif connected_door.opened:
		unlit.visible = false
		lit.visible = true


func activate():
	if unlit.visible and not connected_door.opened:
		connected_door.open()
		unlit.visible = false
		lit.visible = true
		sensor_activate.play()
