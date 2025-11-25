extends Control


@onready var label: Label = $PanelContainer/Label

var deaths_in_tens: int


func _process(_delta: float) -> void:
	remove_hunds()
	update_label()


func remove_hunds() -> void:
	if Global.death_count < 100:
		deaths_in_tens = Global.death_count
	else:
		deaths_in_tens = Global.death_count - floor(float(Global.death_count)/100) * 100


func update_label() -> void:
	if Global.death_count < 10:
		label.text = "   0" + str(deaths_in_tens)
	else:
		label.text = "   " + str(deaths_in_tens)
