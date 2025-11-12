extends StaticBody2D


@export var direction: String = "Up"


func _ready() -> void:
	format_dir()
	dir_rotation()


func dir_rotation() -> void:
	if direction == "u":
		rotation_degrees = 0
	elif direction == "d":
		rotation_degrees = 180
	elif direction == "l":
		rotation_degrees = -90
	elif direction == "r":
		rotation_degrees = 90


func format_dir() -> void:
	match direction.to_lower():
		"u":
			direction = direction.to_lower()
		"d":
			direction = direction.to_lower()
		"l":
			direction = direction.to_lower()
		"r":
			direction = direction.to_lower()
		"up":
			direction = "u"
		"down":
			direction = "d"
		"left":
			direction = "l"
		"right":
			direction = "r"
