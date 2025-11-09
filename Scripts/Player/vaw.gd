extends CharacterBody2D


#region vars

@onready var ap: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite
@onready var norm_col: CollisionShape2D = $NormCol
@onready var wave_col: CollisionPolygon2D = $WaveCol
@onready var coyote_timer: Timer = $"Jump Timers/CoyoteTimer"
@onready var j_buffer_timer: Timer = $"Jump Timers/JBufferTimer"
@onready var dir_choose_timer: Timer = $DirChooseTimer


const SPEED = 3000.0
const SINE_SPD = 2000.0
const DIA_SINE_SPD = SINE_SPD/sqrt(2)
const LUME_SPD = 5000.0
const DIA_LUME_SPD = LUME_SPD/sqrt(2)
const JUMP_VELOCITY = -160.0
const GRAV = 570.0
const F_GRAV = 750.0 # Fall gravity


var direction
var grav
var spd
var form = "norm"
var awaiting_dir = false
var sine_used = false
var lume_used = false
var coyote_time = false
var jump_buffering = false
var transforming = false
var wave_dir = ""
var wave_dia = false
var no_x_wdir = false
var no_y_wdir = false

#endregion


func _physics_process(delta: float) -> void:
	# Waveforms
	formshift()
	form_collision()
	reset_uses()
	wave_spds(delta)
	wave_direction()
	
	# Movement
	gravity(delta)
	move(delta)
	jump()
	jump_buffer()
	coyote_time_set()
	
	# Animations
	handle_anims()
	
	
	move_and_slide()


func formshift() -> void:
	if form == "norm":
		if Input.is_action_just_pressed("sine") and sine_used == false:
			form = "sine"
			sine_used = true
			velocity = Vector2(0, 0)
			dir_choose_timer.start()
			transforming = true
		elif Input.is_action_just_pressed("lume") and lume_used == false:
			form = "lume"
			lume_used = true
			velocity = Vector2(0, 0)
			dir_choose_timer.start()
			transforming = true
	elif form == "sine":
		if Input.is_action_just_released("sine"):
			form = "norm"
			wave_dir = ""
			velocity = Vector2(0, 0)
	elif form == "lume":
		if Input.is_action_just_released("lume"):
			form = "norm"
			wave_dir = ""
			velocity = Vector2(0, 0)


func form_collision() -> void:
	if form == "norm":
		collision_mask = 0b00001111
		norm_col.disabled = false
		wave_col.disabled = true
	elif form == "sine":
		collision_mask = 0b00001001
		norm_col.disabled = true
		wave_col.disabled = false
	elif form == "lume":
		collision_mask = 0b00000101
		norm_col.disabled = true
		wave_col.disabled = false


func reset_uses() -> void:
	if is_on_floor():
		sine_used = false
		lume_used = false


func wave_spds(delta) -> void:
	# Check for diagonal
	if wave_dir.length() > 1:
		wave_dia = true
	else:
		wave_dia = false
	
	# Set speeds
	if form == "sine":
		if not wave_dia:
			spd = SINE_SPD
		else:
			spd = DIA_SINE_SPD
	elif form == "lume":
		if not wave_dia:
			spd = LUME_SPD
		else:
			spd = DIA_LUME_SPD
	
	# Apply speed
	if not form == "norm":
		if wave_dir == "r":
			velocity.x = spd * delta
		elif wave_dir == "l":
			velocity.x = -spd * delta
		elif wave_dir == "d":
			velocity.y = spd * delta
		elif wave_dir == "u":
			velocity.y = -spd * delta
		elif wave_dir == "ur":
			velocity.x = spd * delta
			velocity.y = -spd * delta
		elif wave_dir == "ul":
			velocity.x = -spd * delta
			velocity.y = -spd * delta
		elif wave_dir == "dr":
			velocity.x = spd * delta
			velocity.y = spd * delta
		elif wave_dir == "dl":
			velocity.x = -spd * delta
			velocity.y = spd * delta


func wave_direction() -> void:
	if awaiting_dir:
		if Input.is_action_pressed("up"):
			awaiting_dir = false
			wave_dir += "u"
			no_y_wdir = false
		elif Input.is_action_pressed("down"):
			awaiting_dir = false
			wave_dir += "d"
			no_y_wdir = false
		else:
			no_y_wdir = true
		if Input.is_action_pressed("left"):
			awaiting_dir = false
			wave_dir += "l"
			no_x_wdir = false
		elif Input.is_action_pressed("right"):
			awaiting_dir = false
			wave_dir += "r"
			no_x_wdir = false
		else:
			no_x_wdir = true
	
	# Default if no directional input
	if no_x_wdir and no_y_wdir:
		awaiting_dir = false
		wave_dir = "r"
		no_x_wdir = false


func gravity(delta) -> void:
	if form == "norm":
		# Set gravity
		if is_falling():
			grav = F_GRAV
		else:
			grav = GRAV
		
		# Apply gravity
		if not is_on_floor():
			velocity.y += GRAV * delta


func move(delta) -> void:
	if form == "norm":
		direction = Input.get_axis("left", "right")
		if direction:
			velocity.x = direction * SPEED * delta
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)


func jump() -> void:
	if form == "norm":
		# Jump
		if (Input.is_action_just_pressed("up") or jump_buffering) and (is_on_floor() or coyote_time):
			velocity.y = JUMP_VELOCITY
			coyote_time = false
			jump_buffering = false
		
		# Jump Cut
		if Input.is_action_just_released("up") and velocity.y < 0:
			velocity.y = 0


func coyote_time_set() -> void:
	if is_on_floor() and not is_jumping():
		coyote_timer.start()
		coyote_time = true


func jump_buffer() -> void:
	if not is_on_floor() and not coyote_time and Input.is_action_just_pressed("up"):
		jump_buffering = true
		j_buffer_timer.start()


func is_jumping() -> bool:
	if velocity.y < 0 and form == "norm":
		return true
	else:
		return false


func is_falling() -> bool:
	if velocity.y > 0 and form == "norm":
		return true
	else:
		return false


func handle_anims() -> void:
	# Sprite Transformations
	if form == "norm":
		if direction > 0:
			sprite.flip_h = false
		elif direction < 0:
			sprite.flip_h = true
		
		sprite.rotation_degrees = 0
	else:
		# Waves
		if wave_dir == "ur":
			sprite.rotation_degrees = 0
		elif wave_dir == "ul":
			sprite.rotation_degrees = -90
		elif wave_dir == "dr":
			sprite.rotation_degrees = 90
		elif wave_dir == "dl":
			sprite.rotation_degrees = 180
		if wave_dir == "r":
			sprite.rotation_degrees = 0
		elif wave_dir == "l":
			sprite.rotation_degrees = 180
		elif wave_dir == "d":
			sprite.rotation_degrees = 90
		elif wave_dir == "u":
			sprite.rotation_degrees = -90
		
		sprite.flip_h = false
	
	
	# Animations
	if form == "norm":
		if direction:
			ap.play("run")
		else:
			ap.play("idle")
	elif form == "sine":
		if transforming:
			ap.play("to_sine_card")
		else:
			if wave_dia:
				ap.play("sine_dia")
			else:
				ap.play("sine_card")
	elif form == "lume":
		if wave_dia:
			ap.play("lume_dia")
		else:
			ap.play("lume_card")


func _on_coyote_timer_timeout() -> void:
	coyote_time = false


func _on_j_buffer_timer_timeout() -> void:
	jump_buffering = false


func _on_dir_choose_timer_timeout() -> void:
	awaiting_dir = true
	transforming = false
