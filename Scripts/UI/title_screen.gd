extends Control


#region vars

@onready var options_ui: Control = $OptionsUI
@onready var underlume: AudioStreamPlayer = $Underlume

var init_vol = 0

#endregion


func _ready() -> void:
	Global.paused = true
	init_vol = underlume.volume_db


func _on_start_pressed() -> void:
	Global.paused = false
	get_tree().change_scene_to_file("res://Scenes/WorldMap/world_map.tscn")


func _on_options_pressed() -> void:
	options_ui.visible = true


func _on_quit_pressed() -> void:
	get_tree().quit()
