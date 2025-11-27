extends Control


#region vars

@onready var options_ui: Control = $OptionsUI
@onready var click: AudioStreamPlayer = $UiMouseClick
@onready var beginnings: AudioStreamPlayer = $TitleScreenBeginnings

var init_vol = 0
var init_click_vol = 0

#endregion


func _ready() -> void:
	Global.paused = true
	init_vol = beginnings.volume_db - 24
	init_click_vol = click.volume_db - 24


func _process(_delta: float) -> void:
	beginnings.volume_db = init_vol + Global.vol
	click.volume_db = init_click_vol + Global.vol


func _on_start_pressed() -> void:
	Global.paused = false
	click.play()
	get_tree().change_scene_to_file("res://Scenes/WorldMap/world_map.tscn")


func _on_options_pressed() -> void:
	options_ui.visible = true
	click.play()


func _on_quit_pressed() -> void:
	click.play()
	get_tree().quit()
