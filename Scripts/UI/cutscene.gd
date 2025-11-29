extends Node2D

var lines: Array = ["IN A WORLD FILLED WITH ECHOES AND LIGHT",
"A POWER PRODUCED, IMPENDING BLIGHT",
"THE NATION'S DEATH, BORN FROM A CRAVE",
"AS THE FINAL WIELDER EXITS THE CAVE"]

var current_line = 0

var skipping = false

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var text: Label = $text


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("skip"):
		skipping = true
		$Transitions.visible = true
		$Transitions.play("close")
	
	if skipping == true:
		$song.volume_db -= 0.5


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
