extends Node2D


@export var connected_door: Node2D


func activate():
	connected_door.open()
