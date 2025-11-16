extends Control


#region vars

#@onready var vaw: CharacterBody2D = $"../.." THIS DOESNT WORK FOR SOME REASON


const WM = preload("res://Scenes/WorldMap/world_map.tscn")


var active = false

#endregion


func _process(_delta: float) -> void:
	pausing()
	
	if active == true:
		get_tree().paused = true
	else:
		get_tree().paused = false


func pausing() -> void:
	if Input.is_action_just_pressed("pause"):
		active = !active
	
	visible = active
	#vaw.inactive = !active


func _on_start_pressed():
	active = false


func _on_options_pressed():
	pass # Replace with function body.


func _on_quit_pressed():
	get_tree().quit()
