extends Control


#region vars

@onready var options_ui: Control = $OptionsUI

#endregion


func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/WorldMap/world_map.tscn")


func _on_options_pressed() -> void:
	options_ui.visible = true


func _on_quit_pressed() -> void:
	get_tree().quit()
