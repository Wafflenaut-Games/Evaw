extends Node


#region vars

@onready var undermain: AudioStreamPlayer = $Undermain
@onready var undersine: AudioStreamPlayer = $Undersine
@onready var underlume: AudioStreamPlayer = $Underlume
@onready var icemain: AudioStreamPlayer = $Icemain
@onready var icesine: AudioStreamPlayer = $Icesine
@onready var icelume: AudioStreamPlayer = $Icelume
@onready var james: AudioStreamPlayer = $james
@onready var gwyn: AudioStreamPlayer = $gwyn
@onready var teo: AudioStreamPlayer = $teo
@onready var roman: AudioStreamPlayer = $roman

#const INIT_VOL = 0

var main_init_vol = 0
var sine_init_vol = 0
var lume_init_vol = 0
var ice_main_init_vol = 0
var ice_sine_init_vol = 0
var ice_lume_init_vol = 0

var music_started = false

#endregion


func _ready() -> void:
	main_init_vol = undermain.volume_db - 24
	sine_init_vol = undersine.volume_db - 24
	lume_init_vol = underlume.volume_db - 24
	ice_main_init_vol = icemain.volume_db - 24
	ice_sine_init_vol = icesine.volume_db - 24
	ice_lume_init_vol = icelume.volume_db - 24


func _process(_delta: float) -> void:
	if Global.level != 10:
		start()
		change_tune()


func change_tune() -> void:
	if Global.water_lvl == "_w":
		undermain.volume_db = -INF
		undersine.volume_db = sine_init_vol + Global.music_vol
		underlume.volume_db = -INF
		icemain.volume_db = -INF
		icesine.volume_db = -INF
		icelume.volume_db = -INF
	elif Global.ice_lvl:
		if Global.vaw_form == "sine" or Global.paused:
			undermain.volume_db = -INF
			undersine.volume_db = -INF
			underlume.volume_db = -INF
			icemain.volume_db = -INF
			icesine.volume_db = ice_sine_init_vol + Global.music_vol
			icelume.volume_db = -INF
		elif Global.vaw_form == "norm":
			undermain.volume_db = -INF
			undersine.volume_db = -INF
			underlume.volume_db = -INF
			icemain.volume_db = ice_main_init_vol + Global.music_vol
			icesine.volume_db = -INF
			icelume.volume_db = -INF
		elif Global.vaw_form == "lume":
			undermain.volume_db = -INF
			undersine.volume_db = -INF
			underlume.volume_db = -INF
			icemain.volume_db = -INF
			icesine.volume_db = -INF
			icelume.volume_db = ice_lume_init_vol + Global.music_vol
	else:
		if Global.vaw_form == "sine" or Global.paused:
			undermain.volume_db = -INF
			undersine.volume_db = sine_init_vol + Global.music_vol
			underlume.volume_db = -INF
			icemain.volume_db = -INF
			icesine.volume_db = -INF
			icelume.volume_db = -INF
		elif Global.vaw_form == "norm":
			undermain.volume_db = main_init_vol + Global.music_vol
			undersine.volume_db = -INF
			underlume.volume_db = -INF
			icemain.volume_db = -INF
			icesine.volume_db = -INF
			icelume.volume_db = -INF
		elif Global.vaw_form == "lume":
			undermain.volume_db = -INF
			undersine.volume_db = -INF
			underlume.volume_db = lume_init_vol + Global.music_vol
			icemain.volume_db = -INF
			icesine.volume_db = -INF
			icelume.volume_db = -INF


func start() -> void:
	if not music_started:
		undermain.play()
		undersine.play()
		underlume.play()
		icemain.play()
		icesine.play()
		icelume.play()
		music_started = true
