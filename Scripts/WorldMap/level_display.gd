extends Node2D


var already_in = false
var already_out = true

@onready var ap: AnimationPlayer = $AnimationPlayer
@onready var level_number: Label = $everything/level_number
@onready var level_name: Label = $everything/level_name
@onready var feather_inline: Sprite2D = $"everything/single feather/feather_inline"
@onready var triple_feather_inline_1: Sprite2D = $"everything/triple feather/triple_feather_inline"
@onready var triple_feather_inline_2: Sprite2D = $"everything/triple feather/triple_feather_inline2"
@onready var triple_feather_inline_3: Sprite2D = $"everything/triple feather/triple_feather_inline3"


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
	
	if Global.wm_hovering != 4 and Global.wm_hovering != 9 and Global.wm_hovering != 7:
		$"everything/triple feather".visible = false
		$"everything/single feather".visible = true
	elif Global.wm_hovering == 4 or Global.wm_hovering == 9 or Global.wm_hovering == 7:
		$"everything/triple feather".visible = true
		$"everything/single feather".visible = false
	
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
			if Global.feather_lvl_4_1:
				triple_feather_inline_1.visible = true
			else:
				triple_feather_inline_1.visible = false
				
			if Global.feather_lvl_4_2:
				triple_feather_inline_2.visible = true
			else:
				triple_feather_inline_2.visible = false
			
			if Global.feather_lvl_4_3:
				triple_feather_inline_3.visible = true
			else:
				triple_feather_inline_3.visible = false
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
			if Global.feather_lvl_7_1:
				triple_feather_inline_1.visible = true
			else:
				triple_feather_inline_1.visible = false
				
			if Global.feather_lvl_7_2:
				triple_feather_inline_2.visible = true
			else:
				triple_feather_inline_2.visible = false
			
			if Global.feather_lvl_7_3:
				triple_feather_inline_3.visible = true
			else:
				triple_feather_inline_3.visible = false
		8:
			if Global.feather_lvl_8:
				feather_inline.visible = true
			else:
				feather_inline.visible = false
		9:
			if Global.feather_lvl_9_1:
				triple_feather_inline_1.visible = true
			else:
				triple_feather_inline_1.visible = false
				
			if Global.feather_lvl_9_2:
				triple_feather_inline_2.visible = true
			else:
				triple_feather_inline_2.visible = false
			
			if Global.feather_lvl_9_3:
				triple_feather_inline_3.visible = true
			else:
				triple_feather_inline_3.visible = false
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
	
