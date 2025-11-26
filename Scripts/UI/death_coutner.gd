extends Control


@onready var label: Label = $PanelContainer/Label


func _process(_delta: float) -> void:
	update_label()


func update_label() -> void:
	if Global.death_count < 10:
		label.text = "00" + str(Global.death_count)
	elif Global.death_count < 100:
		label.text = "0" + str(Global.death_count)
	else:
		label.text = str(Global.death_count)
