extends Node2D


var activated = false

func _process(_delta: float) -> void:
	#print(str(Global.vaw_form))
	pass

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		 
		if Global.vaw_form == "sine":
			activated = true
			print("activated")
