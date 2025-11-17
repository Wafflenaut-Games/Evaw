extends Control


#region vars

@onready var vaw: CharacterBody2D = $"../.."


var active = false
var reset_inactive = true

#endregion


func _process(_delta: float) -> void:
	pausing()


func pausing() -> void:
	if Input.is_action_just_pressed("pause"):
		active = !active
		reset_inactive = false
	
	visible = active
	
	if active:
		vaw.inactive = true
	elif not active and not reset_inactive:
		vaw.inactive = false
		reset_inactive = true


func _on_start_pressed() -> void:
	active = false


func _on_options_pressed() -> void:
	pass # Replace with function body.


func _on_quit_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/UI/title_screen.tscn")
