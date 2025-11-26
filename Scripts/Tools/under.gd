extends Node


#region vars

@onready var undermain: AudioStreamPlayer = $Undermain
@onready var undersine: AudioStreamPlayer = $Undersine
@onready var underlume: AudioStreamPlayer = $Underlume

const INIT_VOL = 0

var main_init_vol = 0
var sine_init_vol = 0
var lume_init_vol = 0

#endregion


func _ready() -> void:
	main_init_vol = undermain.volume_db
	sine_init_vol = undersine.volume_db
	lume_init_vol = underlume.volume_db


func _process(_delta: float) -> void:
	change_tune()


func change_tune() -> void:
	if Global.water_lvl == "_w":
		undermain.volume_db = -80
		undersine.volume_db = sine_init_vol + Global.vol
		underlume.volume_db = -80
	else:
		if Global.vaw_form == "norm":
			undermain.volume_db = main_init_vol + Global.vol
			undersine.volume_db = -80
			underlume.volume_db = -80
		if Global.vaw_form == "sine":
			undermain.volume_db = -80
			undersine.volume_db = sine_init_vol + Global.vol
			underlume.volume_db = -80
		if Global.vaw_form == "lume":
			undermain.volume_db = -80
			undersine.volume_db = -80
			underlume.volume_db = lume_init_vol + Global.vol
