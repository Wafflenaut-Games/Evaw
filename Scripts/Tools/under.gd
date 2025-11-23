extends Node


#region vars

@onready var undermain: AudioStreamPlayer = $Undermain
@onready var undersine: AudioStreamPlayer = $Undersine
@onready var underlume: AudioStreamPlayer = $Underlume

var vol = 0


#endregion


func _process(_delta: float) -> void:
	change_tune()
	change_volume()


func change_tune() -> void:
	if Global.vaw_form == "norm":
		undermain.volume_db = vol
		undersine.volume_db = -80
		underlume.volume_db = -80
	if Global.vaw_form == "sine":
		undermain.volume_db = -80
		undersine.volume_db = vol
		underlume.volume_db = -80
	if Global.vaw_form == "lume":
		undermain.volume_db = -80
		undersine.volume_db = -80
		underlume.volume_db = vol


func change_volume() -> void:
	vol += Global.vol - 5
