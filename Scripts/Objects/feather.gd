extends Node2D

#JAMES READ THIS BASICALLY YOU GOTTA MAKE FEATHER SPEED CHANGE WITH DIFFERENT WAVE FORMS done
#AND FINISH THE LEVEL DISPLAY IN THE WORLDMAP done AND MAKE THE FEATHERS RESET WHEN YOU DIE

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $PointLight2D/AnimationPlayer


var starting_pos: Vector2

var collecting = false

var start_speed = randf_range(25,50)
var real_speed = start_speed

var player

func random_timer():
	await get_tree().create_timer(randf_range(1,5)).timeout
	animation_player.play("light stuff")
	random_timer()

func _ready() -> void:
	real_speed = start_speed
	starting_pos = global_position
	animated_sprite_2d.frame = randi_range(0,9)
	random_timer()


func _process(delta: float) -> void:
	# Reset when you die
	if Global.respawning:
		global_position = starting_pos
	
	# End level
	if Global.is_transitioning:
		if collecting == true:
			match Global.level:
				1:
					Global.feather_lvl_1 = true
				2:
					Global.feather_lvl_2 = true
				3:
					Global.feather_lvl_3 = true
				4:
					Global.feather_lvl_4 = true
				5:
					Global.feather_lvl_5 = true
				6:
					Global.feather_lvl_6 = true
				7:
					Global.feather_lvl_7 = true
				8:
					Global.feather_lvl_8 = true
				9:
					Global.feather_lvl_9 = true
				10:
					Global.feather_lvl_10 = true
				11:
					Global.feather_lvl_11 = true
				12:
					Global.feather_lvl_12 = true
				13:
					Global.feather_lvl_13 = true
				14:
					Global.feather_lvl_14 = true
				15:
					Global.feather_lvl_15 = true
				16:
					Global.feather_lvl_16 = true
	
	if Global.vaw_form == "norm":
		real_speed = start_speed
	if Global.vaw_form == "sine":
		real_speed = start_speed * 0.6
	if Global.vaw_form == "lume":
		real_speed = start_speed * 1.67
	
	if collecting == true:
		if global_position.distance_to(player.global_position) < 16:
			real_speed = lerp(real_speed,0.0,0.8)
		
		global_position = global_position.move_toward(player.global_position, real_speed * delta)


func collect(body):
	player = body
	collecting = true
