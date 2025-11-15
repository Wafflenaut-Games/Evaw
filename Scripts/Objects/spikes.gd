extends Node2D


#region vars

@onready var ap: AnimatedSprite2D = $AnimatedSprite2D
@onready var hitbox: Area2D = $Area2D
@onready var vaw: CharacterBody2D = $"../../Vaw"
@onready var damager: CollisionShape2D = $Area2D/CollisionShape2D

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
	ap.play(type.to_lower() + "_" + direction.to_lower())
	
	# Hitbox rotation
	if direction == "u":
		hitbox.rotation_degrees = 0
	elif direction == "d":
		hitbox.rotation_degrees = 180
	elif direction == "l":
		hitbox.rotation_degrees = -90
	elif direction == "r":
		hitbox.rotation_degrees = 90


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
		damager.disabled = false
	elif type == "steel":
		if Global.vaw_form == "sine":
			damager.disabled = true
		else:
			damager.disabled = false
	elif type == "glass":
		if Global.vaw_form == "lume":
			damager.disabled = true
		else:
			damager.disabled = false
