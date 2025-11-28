extends Control


#region vars

@onready var options_ui: Control = $OptionsUI
@onready var click: AudioStreamPlayer = $UiMouseClick
@onready var beginnings: AudioStreamPlayer = $TitleScreenBeginnings
@onready var color_rect_2: ColorRect = $"../Worldmap10/ColorRect2"
@onready var apcrt: AnimationPlayer = $"../Worldmap10/apcrt"
@onready var apworld: AnimationPlayer = $"../WorldMap/apworld"

var music_started = false

#endregion


func _ready() -> void:
	Global.paused = true


func _process(_delta: float) -> void:
	start()


func start() -> void:
	if not music_started:
		beginnings.play()
		music_started = true


func _on_start_pressed() -> void:
	click.play()
	apcrt.play("zoom")
	apworld.play("zoom 2")


func _on_options_pressed() -> void:
	options_ui.visible = true
	click.play()


func _on_quit_pressed() -> void:
	click.play()
	get_tree().quit()


func _on_apworld_animation_finished(anim_name: StringName) -> void:
	Global.paused = false
	get_tree().change_scene_to_file("res://Scenes/WorldMap/world_map.tscn")
