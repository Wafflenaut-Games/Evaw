extends Control


#region vars
@onready var difficulty_label: Label = $PanelContainer/MarginContainer/VBoxContainer/Difficulty/DIFFICULTY
@onready var volume_label: Label = $PanelContainer/MarginContainer/VBoxContainer/Volume/VOLUME
@onready var volume_bar: HSlider = $PanelContainer/MarginContainer/VBoxContainer/Volume/VolumeBar


enum difficulty {easy = 4, normal = 2, wavemaster = 1}

#endregion


func _process(_delta: float) -> void:
	volume()
	labels()


func labels() -> void:
	volume_label.text = "VOLUME: %s" % str(int(Global.vol))
	
	if Global.difficulty == 4:
		difficulty_label.text = "DIFFICULTY: EASY"
	elif Global.difficulty == 2:
		difficulty_label.text = "DIFFICULTY: NORMAL"
	elif Global.difficulty == 1:
		difficulty_label.text = "DIFFICULTY: WAVEMASTER"


func volume() -> void:
	Global.vol = volume_bar.value


func _on_easy_pressed() -> void:
	Global.difficulty = difficulty.easy


func _on_normal_pressed() -> void:
	Global.difficulty = difficulty.normal


func _on_wavemaster_pressed() -> void:
	Global.difficulty = difficulty.wavemaster


func _on_back_pressed() -> void:
	visible = false
