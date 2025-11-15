extends Node2D


#region vars

@onready var vaw: CharacterBody2D = $"../../WorldMap_Vaw"

@export var v_dir: String
@export var dir: String

#endregion


func _process(delta: float) -> void:
	change_vaw_dir(delta)


func change_vaw_dir(delta) -> void:
	if round(vaw.position) == round(position):
		if vaw.v_moving == false:
			if v_dir.to_lower() == "up":
				vaw.velocity.y = -vaw.V_SPD * delta
			elif v_dir.to_lower() == "down":
				vaw.velocity.y = vaw.V_SPD * delta
			vaw.velocity.x = 0
		else:
			if dir.to_lower() == "left":
				vaw.velocity.x = -vaw.SPEED * delta
				vaw.velocity.y = 0
			elif dir.to_lower() == "right":
				vaw.velocity.x = vaw.SPEED * delta
				vaw.velocity.y = 0
			elif dir.to_lower() == "up":
				vaw.velocity.y = -vaw.SPEED * delta
				vaw.velocity.x = 0
			elif dir.to_lower() == "down":
				vaw.velocity.y = vaw.SPEED * delta
				vaw.velocity.x = 0


func _on_body_exited(body: Node2D) -> void:
	if body == vaw:
		if vaw.v_moving == false:
			vaw.v_moving = true
		else:
			vaw.v_moving = false
