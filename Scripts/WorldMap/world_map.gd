extends Node2D


@onready var world_map: AudioStreamPlayer = $WorldMap

var init_vol = 0
var music_started = false


func _ready() -> void:
	Global.level = 0
	init_vol = world_map.volume_db - 24


func _process(_delta: float) -> void:
	start()
	#world_map.volume_db = init_vol + Global.vol


func start() -> void:
	if not music_started:
		world_map.play()
		music_started = true
