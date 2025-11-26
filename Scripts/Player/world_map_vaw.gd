extends CharacterBody2D


#region vars

@onready var ap: AnimatedSprite2D = $AnimatedSprite2D
@onready var transitions: AnimatedSprite2D = $"../Transitions"
@onready var level_display: Node2D = $"../level_display"
@onready var open_timer: Timer = $"../OpenTimer"
@onready var walking: AudioStreamPlayer = $WorldMapWalking


const SPEED = 1000.0
const V_SPD = 600.0

var stopped = false
var selecting = false
var v_moving = false
var lvl_disply_fading = false
var inactive = true

#endregion


func _ready() -> void:
	transitions.play("open")
	open_timer.start()
	Global.is_transitioning = false


func _physics_process(delta: float) -> void:
	if velocity != Vector2.ZERO:
		Global.wm_hovering = 0
	
	if not inactive:
		move(delta)
		handle_anims()
		move_and_slide()


func move(delta) -> void:
	if not Global.lvl_selected:
		if Input.is_action_just_pressed("up") and Global.world_map_dirs.has("up"):
			velocity.y = -SPEED * delta
			Global.world_map_dirs = []
			walking.play()
		elif Input.is_action_just_pressed("down") and Global.world_map_dirs.has("down"):
			velocity.y = SPEED * delta
			Global.world_map_dirs = []
			walking.play()
		elif Input.is_action_just_pressed("left") and Global.world_map_dirs.has("left"):
			velocity.x = -SPEED * delta
			Global.world_map_dirs = []
			walking.play()
		elif Input.is_action_just_pressed("right") and Global.world_map_dirs.has("right"):
			velocity.x = SPEED * delta
			Global.world_map_dirs = []
			walking.play()


func handle_anims() -> void:
	if selecting:
		ap.play("select")
	else:
		if not stopped:
			if velocity.x > 0:
				ap.play("walk")
				ap.flip_h = false
			elif velocity.x < 0:
				ap.play("walk")
				ap.flip_h = true
			elif velocity.y > 0:
				ap.play("walk_front")
				ap.flip_h = false
			elif velocity.y < 0:
				ap.play("walk_back")
				ap.flip_h = false
		else:
			ap.play("idle")
	
	
	if Global.is_transitioning:
		transitions.play("close")
		
		if not lvl_disply_fading:
			level_display.ap.play("fade_out")
			lvl_disply_fading = true


func _on_open_timer_timeout() -> void:
	inactive = false
