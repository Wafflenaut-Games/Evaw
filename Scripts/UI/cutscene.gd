extends Node2D

var lines: Array = ["In a world filled with echoes and light",
"A power produced, impending blight",
"The nation's death born from a crave",
"As the final wielder exits the cave"]

var current_line = 0

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var text: Label = $text


func _ready() -> void:
	text.text = lines[current_line]


func _on_texttimer_timeout() -> void:
	text.visible_characters += 1


func _on_timer_timeout() -> void:
	if current_line == 3:
		$Transitions.visible = true
		$Transitions.play("close")
	else:
		text.visible_characters = 0
		current_line += 1
		text.text = lines[current_line]
		animated_sprite_2d.frame = animated_sprite_2d.frame + 1


func _on_transitions_animation_finished() -> void:
	get_tree().change_scene_to_file("res://Scenes/UI/titlescreen.tscn")
