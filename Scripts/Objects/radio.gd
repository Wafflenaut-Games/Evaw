extends Area2D


#region var

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var you_have_one_new_message: AudioStreamPlayer = $YouHaveOneNewMessage

var interactable = false
var interacting = false

#endregion


func _process(_delta: float) -> void:
	set_interacting()


func set_interacting() -> void:
	if Input.is_action_just_pressed("interact") and interactable:
		if interacting == false:
			interacting = !interacting
			you_have_one_new_message.play()
		else:
			interacting = !interacting


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		interactable = true


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		interactable = false
		interacting = false
