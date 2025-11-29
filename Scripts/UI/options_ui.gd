extends Control


#region vars
@onready var difficulty_label: Label = $PanelContainer/MarginContainer/HBoxContainer/Preferences/Difficulty/DIFFICULTY
@onready var click: AudioStreamPlayer = $UiMouseClick
@onready var main: VSlider = $PanelContainer/MarginContainer/HBoxContainer/Volume/Volume/HBoxContainer/Main/Main
@onready var music: VSlider = $PanelContainer/MarginContainer/HBoxContainer/Volume/Volume/HBoxContainer/Music/Music
@onready var sfx: VSlider = $PanelContainer/MarginContainer/HBoxContainer/Volume/Volume/HBoxContainer/SFX/sfx
@onready var easy: Button = $PanelContainer/MarginContainer/HBoxContainer/Preferences/Difficulty/HBoxContainer/Easy
@onready var normal: Button = $PanelContainer/MarginContainer/HBoxContainer/Preferences/Difficulty/HBoxContainer/Normal
@onready var wavemaster: Button = $PanelContainer/MarginContainer/HBoxContainer/Preferences/Difficulty/Wavemaster


enum difficulty {easy = 1, normal = 2, wavemaster = 3}


var init_vol = 0

#endregion


func _ready() -> void:
	init_vol = click.volume_db - 24
	main.value = int((float(Global.main_vol) + 5) / 5 + 9)
	music.value = int((float(Global.music_vol) + 5) / 5 + 9)
	sfx.value = int((float(Global.sfx_vol) + 5) / 5 + 9)


func _process(_delta: float) -> void:
	volume()
	labels()
	difficulty_icons()


func labels() -> void:
	
	if Global.difficulty == 1:
		difficulty_label.text = "DIFFICULTY: EASY"
	elif Global.difficulty == 2:
		difficulty_label.text = "DIFFICULTY: NORMAL"
	elif Global.difficulty == 3:
		difficulty_label.text = "DIFFICULTY: WAVEMASTER"


func volume() -> void:
	if main.value > 0:
		Global.main_vol = ((main.value - 5) * 5) - 25
	else:
		Global.main_vol = -INF
	
	if music.value > 0:
		Global.music_vol = ((music.value - 5) * 5) - 25
	else:
		Global.music_vol = -INF
	
	if sfx.value > 0:
		Global.sfx_vol = ((sfx.value - 5) * 5) - 25
	else:
		Global.sfx_vol = -INF
	
	#click.volume_db = init_vol + Global.vol


func difficulty_icons() -> void:
	if Global.difficulty == difficulty.easy:
		easy.icon = load("res://Assets/Interactables/buttonpress-export.png")
		normal.icon = load("res://Assets/Interactables/buttonpress.png")
		wavemaster.icon = load("res://Assets/Interactables/buttonpress.png")
	if Global.difficulty == difficulty.normal:
		easy.icon = load("res://Assets/Interactables/buttonpress.png")
		normal.icon = load("res://Assets/Interactables/buttonpress-export.png")
		wavemaster.icon = load("res://Assets/Interactables/buttonpress.png")
	if Global.difficulty == difficulty.wavemaster:
		easy.icon = load("res://Assets/Interactables/buttonpress.png")
		normal.icon = load("res://Assets/Interactables/buttonpress.png")
		wavemaster.icon = load("res://Assets/Interactables/buttonpress-export.png")


func _on_easy_pressed() -> void:
	click.play()
	Global.difficulty = difficulty.easy


func _on_normal_pressed() -> void:
	click.play()
	Global.difficulty = difficulty.normal


func _on_wavemaster_pressed() -> void:
	click.play()
	Global.difficulty = difficulty.wavemaster


func _on_back_pressed() -> void:
	click.play()
	visible = false


func _on_volume_bar_drag_started() -> void:
	click.play()


func _on_wave_display_clicked() -> void:
	click.play()
