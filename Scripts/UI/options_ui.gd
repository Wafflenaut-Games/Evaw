extends Control


#region vars
@onready var difficulty_label: Label = $PanelContainer/MarginContainer/VBoxContainer/Difficulty/DIFFICULTY
@onready var volume_label: Label = $PanelContainer/MarginContainer/VBoxContainer/Volume/VOLUME
@onready var click: AudioStreamPlayer = $UiMouseClick
@onready var main: VSlider = $PanelContainer/MarginContainer/HBoxContainer/Volume/Volume/HBoxContainer/Main/Main
@onready var music: VSlider = $PanelContainer/MarginContainer/HBoxContainer/Volume/Volume/HBoxContainer/Music/Music
@onready var sfx: VSlider = $PanelContainer/MarginContainer/HBoxContainer/Volume/Volume/HBoxContainer/SFX/sfx


enum difficulty {easy = 4, normal = 2, wavemaster = 1}


var init_vol = 0

#endregion


func _ready() -> void:
	init_vol = click.volume_db - 24
	main.value = int((float(Global.vol) + 5) / 5 + 9)
	music.value = int((float(Global.vol) + 5) / 5 + 9)
	sfx.value = int((float(Global.vol) + 5) / 5 + 9)


func _process(_delta: float) -> void:
	volume()
	labels()


func labels() -> void:
	
	if Global.difficulty == 4:
		difficulty_label.text = "DIFFICULTY: EASY"
	elif Global.difficulty == 2:
		difficulty_label.text = "DIFFICULTY: NORMAL"
	elif Global.difficulty == 1:
		difficulty_label.text = "DIFFICULTY: WAVEMASTER"


func volume() -> void:
	if main.value > 0:
		Global.main_vol = ((main.value - 5) * 5) - 25
	else:
		Global.main_vol = -INF
	
	click.volume_db = init_vol + Global.vol


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
