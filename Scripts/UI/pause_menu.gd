extends Control


#region vars

@onready var vaw: CharacterBody2D = $"../.."
@onready var options_ui: Control = $OptionsUI


var active = false
var reset_inactive = true

#endregion


func _process(_delta: float) -> void:
	pausing()
	position = Vector2.ZERO


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
	active = false


func _on_options_pressed() -> void:
	options_ui.visible = true


func _on_quit_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/UI/title_screen.tscn")
