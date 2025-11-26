extends Control


#region vars

@onready var label: Label = $PanelContainer/VBoxContainer/Label
@onready var pause_ui: Control = $".."


var secs = 00
var mins = 0

#endregion


func _ready() -> void:
	mins = Global.mins
	secs = Global.secs


func _process(_delta: float) -> void:
	secs_to_mins()
	update_label()
	update_vars()


func update_vars() -> void:
	Global.mins = mins
	Global.secs = secs
	
	if pause_ui.visible: visible = true
	else: visible = false


func secs_to_mins() -> void:
	if secs == 60:
		mins += 1
		secs = 0


func update_label() -> void:
	if secs > 9:
		label.text = str(mins) + ":" + str(secs)
	else:
		label.text = str(mins) + ":0" + str(secs)


func _on_timer_timeout() -> void:
	if not Global.paused and not Global.is_transitioning:
		secs += 1
