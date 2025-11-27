extends Control


#region vars

@onready var vaw: CharacterBody2D = $"../.."
@onready var options_ui: Control = $OptionsUI
@onready var click: AudioStreamPlayer = $UiMouseClick


var active = false
var reset_inactive = true
var init_vol = 0

#endregion


func _ready() -> void:
	init_vol = click.volume_db - 24


func _process(_delta: float) -> void:
	pausing()
	position = Vector2.ZERO
	click.volume_db = init_vol + Global.vol


func pausing() -> void:
	if Input.is_action_just_pressed("pause") and not Global.is_transitioning:
		active = !active
		reset_inactive = false
	
	visible = active
	
	if active:
		Global.paused = true
		if vaw.name == "Vaw":
			vaw.inactive = true
	elif not active and not reset_inactive:
		reset_inactive = true
		if vaw.name == "Vaw":
			vaw.inactive = false
	else:
		Global.paused = false


func _on_start_pressed() -> void:
	click.play()
	active = false


func _on_options_pressed() -> void:
	click.play()
	options_ui.visible = true


func _on_quit_pressed() -> void:
	click.play()
	get_tree().change_scene_to_file("res://Scenes/UI/title_screen.tscn")
