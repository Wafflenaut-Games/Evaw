extends Area2D


#region var

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

#endregion


func _process(_delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		Global.interactable = true
