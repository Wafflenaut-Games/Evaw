extends Control


#region vars
@onready var difficulty_label: Label = $PanelContainer/MarginContainer/VBoxContainer/Difficulty/DIFFICULTY
@onready var volume_label: Label = $PanelContainer/MarginContainer/VBoxContainer/Volume/VOLUME
@onready var volume_bar: HSlider = $PanelContainer/MarginContainer/VBoxContainer/Volume/VolumeBar


enum difficulty {easy = 4, normal = 2, wavemaster = 1}

#endregion


func _ready() -> void:
	volume_bar.value = Global.vol


func _process(_delta: float) -> void:
	volume()
	labels()


func labels() -> void:
	if not Global.vol == -80:
		volume_label.text = "VOLUME: %s" % str(int((float(Global.vol) + 5)/ 5 + 9))
	else:
		volume_label.text = "VOLUME: 0"
	
	if Global.difficulty == 4:
		difficulty_label.text = "DIFFICULTY: EASY"
	elif Global.difficulty == 2:
		difficulty_label.text = "DIFFICULTY: NORMAL"
	elif Global.difficulty == 1:
		difficulty_label.text = "DIFFICULTY: WAVEMASTER"


func volume() -> void:
	if volume_bar.value > 0:
		Global.vol = ((volume_bar.value - 5) * 5) - 25
	else:
		Global.vol = -INF


func _on_easy_pressed() -> void:
	Global.difficulty = difficulty.easy


func _on_normal_pressed() -> void:
	Global.difficulty = difficulty.normal


func _on_wavemaster_pressed() -> void:
	Global.difficulty = difficulty.wavemaster


func _on_back_pressed() -> void:
	visible = false
