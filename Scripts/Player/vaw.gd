extends CharacterBody2D


#region vars

@onready var ap: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite
@onready var norm_col: CollisionShape2D = $NormCol
@onready var wave_col: CollisionPolygon2D = $WaveCol
@onready var coyote_timer: Timer = $"Jump Timers/CoyoteTimer"
@onready var j_buffer_timer: Timer = $"Jump Timers/JBufferTimer"

const SPEED = 3000.0
const SINE_SPD = 2000.0
const LUME_SPD = 5000.0
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

#endregion


func _physics_process(delta: float) -> void:
	# Waveforms
	formshift()
	form_collision()
	reset_uses()
	wave_spds()
	wave_dir(delta)
	
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
			awaiting_dir = true
		elif Input.is_action_just_pressed("lume") and lume_used == false:
			form = "lume"
			lume_used = true
			velocity = Vector2(0, 0)
			awaiting_dir = true
	elif form == "sine":
		if Input.is_action_just_released("sine"):
			form = "norm"
			velocity = Vector2(0, 0)
	elif form == "lume":
		if Input.is_action_just_released("lume"):
			form = "norm"
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


func wave_spds() -> void:
	if form == "sine":
		spd = SINE_SPD
	elif form == "lume":
		spd = LUME_SPD


func wave_dir(delta) -> void:
	if awaiting_dir == true:
		if Input.is_action_just_pressed("up"):
			velocity.y = -spd * delta
			awaiting_dir = false
		if Input.is_action_just_pressed("down"):
			velocity.y = spd * delta
			awaiting_dir = false
		if Input.is_action_just_pressed("left"):
			velocity.x = -spd * delta
			awaiting_dir = false
		if Input.is_action_just_pressed("right"):
			velocity.x = spd * delta
			awaiting_dir = false


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
	else: # Waves
		# Diagonal
		if velocity.y < 0 and velocity.x > 0:
			sprite.rotation_degrees = 0
		elif velocity.y < 0 and velocity.x < 0:
			sprite.rotation_degrees = -90
		elif velocity.y > 0 and velocity.x > 0:
			sprite.rotation_degrees = 90
		elif velocity.y > 0 and velocity.x < 0:
			sprite.rotation_degrees = 180
		else:
			# Cardinal
			if velocity.x > 0:
				sprite.rotation_degrees = 0
			elif velocity.x < 0:
				sprite.rotation_degrees = 180
			elif velocity.y > 0:
				sprite.rotation_degrees = 90
			elif velocity.y < 0:
				sprite.rotation_degrees = -90
		
		sprite.flip_h = false
	
	
	# Animations
	if form == "norm":
		if direction:
			ap.play("run")
		else:
			ap.play("idle")
	elif form == "sine":
		if not velocity.y == 0 and not velocity.x == 0:
			ap.play("sine_dia")
		elif velocity.y == 0 and velocity.x == 0:
			ap.play("")
		else:
			ap.play("sine_card")
	elif form == "lume":
		if not velocity.y == 0 and not velocity.x == 0:
			ap.play("lume_dia")
		elif velocity.y == 0 and velocity.x == 0:
			ap.play("")
		else:
			ap.play("lume_card")


func _on_coyote_timer_timeout() -> void:
	coyote_time = false


func _on_j_buffer_timer_timeout() -> void:
	jump_buffering = false
