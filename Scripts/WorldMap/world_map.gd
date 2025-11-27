extends Node2D


@onready var world_map: AudioStreamPlayer = $WorldMap

var init_vol = 0


func _ready() -> void:
	init_vol = world_map.volume_db - 24


func _process(_delta: float) -> void:
	world_map.volume_db = init_vol + Global.vol
