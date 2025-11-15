extends Control
const WM = preload("res://Scenes/WorldMap/world_map.tscn")

func _on_start_pressed():
	get_tree().change_scene_to_packed(WM)


func _on_options_pressed():
	pass # Replace with function body.


func _on_quit_pressed():
	get_tree().quit()
