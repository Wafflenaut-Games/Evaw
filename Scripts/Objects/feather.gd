extends Node2D

#JAMES READ THIS BASICALLY YOU GOTTA MAKE FEATHER SPEED CHANGE WITH DIFFERENT WAVE FORMS done
#AND FINISH THE LEVEL DISPLAY IN THE WORLDMAP AND MAKE THE FEATHERS RESET WHEN YOU DIE

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $PointLight2D/AnimationPlayer


@export var level: int = 1

var starting_pos: Vector2

var collecting = false

var start_speed = randf_range(15,100)
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
