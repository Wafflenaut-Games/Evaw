extends Node2D


var already_in = false
var already_out = true

@onready var ap: AnimationPlayer = $AnimationPlayer
@onready var level_number: Label = $everything/level_number
@onready var level_name: Label = $everything/level_name
@onready var feather_inline: Sprite2D = $everything/feather_inline


func _process(_delta: float) -> void:
	
	# Animations
	if !already_out:
		if Global.wm_hovering == 0:
			ap.play("fade_out")
			already_out = true
			already_in = false
	if !already_in:
		if Global.wm_hovering != 0:
			ap.play("fade_in")
			already_in = true
			already_out = false
	
	# Level number
	if Global.wm_hovering != 0:
		level_number.text = "Level " + str(Global.wm_hovering)
	
	# Level name
	if Global.wm_hovering != 0:
		level_name.text = str(Global.lvl_names[Global.wm_hovering - 1])
	
	#region Feather
	match Global.wm_hovering:
		1:
			if Global.feather_lvl_1:
				feather_inline.visible = true
			else:
				feather_inline.visible = false
		2:
			if Global.feather_lvl_2:
				feather_inline.visible = true
			else:
				feather_inline.visible = false
		3:
			if Global.feather_lvl_3:
				feather_inline.visible = true
			else:
				feather_inline.visible = false
		4:
			if Global.feather_lvl_4:
				feather_inline.visible = true
			else:
				feather_inline.visible = false
		5:
			if Global.feather_lvl_5:
				feather_inline.visible = true
			else:
				feather_inline.visible = false
		6:
			if Global.feather_lvl_6:
				feather_inline.visible = true
			else:
				feather_inline.visible = false
		7:
			if Global.feather_lvl_7:
				feather_inline.visible = true
			else:
				feather_inline.visible = false
		8:
			if Global.feather_lvl_8:
				feather_inline.visible = true
			else:
				feather_inline.visible = false
		9:
			if Global.feather_lvl_9:
				feather_inline.visible = true
			else:
				feather_inline.visible = false
		10:
			if Global.feather_lvl_10:
				feather_inline.visible = true
			else:
				feather_inline.visible = false
		11:
			if Global.feather_lvl_11:
				feather_inline.visible = true
			else:
				feather_inline.visible = false
		12:
			if Global.feather_lvl_12:
				feather_inline.visible = true
			else:
				feather_inline.visible = false
		13:
			if Global.feather_lvl_13:
				feather_inline.visible = true
			else:
				feather_inline.visible = false
		14:
			if Global.feather_lvl_14:
				feather_inline.visible = true
			else:
				feather_inline.visible = false
		15:
			if Global.feather_lvl_15:
				feather_inline.visible = true
			else:
				feather_inline.visible = false
		16:
			if Global.feather_lvl_16:
				feather_inline.visible = true
			else:
				feather_inline.visible = false
	#endregion
	
