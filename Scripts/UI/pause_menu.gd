extends Control


#region vars

@onready var vaw: CharacterBody2D = $"../../.."


const WM = preload("res://Scenes/WorldMap/world_map.tscn")

var active = false

#endregion


func _process(_delta: float) -> void:
	pausing()


func pausing() -> void:
	if Input.is_action_just_pressed("pause"):
		active = !active
	
	visible = active
	
	if active == true:
		vaw.inactive = true
	else:
		vaw.inactive = false


func _on_start_pressed() -> void:
	active = false


func _on_options_pressed() -> void:
	pass # Replace with function body.


func _on_quit_pressed() -> void:
	get_tree().quit()
