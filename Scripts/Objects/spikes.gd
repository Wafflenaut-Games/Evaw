extends Node2D


#region vars

@onready var aspr: AnimatedSprite2D = $AnimatedSprite2D
@onready var ap: AnimationPlayer = $AnimationPlayer
@onready var vaw: CharacterBody2D = $"../../../Vaw"
@onready var hitbox: CollisionShape2D = $Area2D/CollisionShape2D

@export var type: String = "Clay"
@export var direction: String = "Up"

#endregion


func _ready() -> void:
	format_exports()
	direction_change()


func _process(_delta: float) -> void:
	active_material()


func direction_change() -> void:
	# Animations
	aspr.play(type.to_lower() + "_" + direction.to_lower())
	
	# Hitbox rotation
	if direction == "u":
		ap.play("up")
	elif direction == "d":
		ap.play("down")
	elif direction == "l":
		ap.play("left")
	elif direction == "r":
		ap.play("right")


func format_exports() -> void:
	type = type.to_lower()
	
	match direction.to_lower():
		"up":
			direction = "u"
		"down":
			direction = "d"
		"left":
			direction = "l"
		"right":
			direction = "r"
		"u":
			direction = "u"
		"d":
			direction = "d"
		"l":
			direction = "l"
		"r":
			direction = "r"


func active_material() -> void:
	if type == "clay":
		hitbox.disabled = false
	elif type == "steel":
		if Global.vaw_form == "sine":
			hitbox.disabled = true
		else:
			hitbox.disabled = false
	elif type == "glass":
		if Global.vaw_form == "lume":
			hitbox.disabled = true
		else:
			hitbox.disabled = false
