extends Node2D


#region Vars

@export var type: String = "clay"
@export var direction: String = "u"

@onready var ap: AnimationPlayer = $AnimationPlayer

#endregion


func _ready() -> void:
	pass


func direction_change() -> void:
	ap.play(type.to_lower() + "_" + direction.to_lower())
