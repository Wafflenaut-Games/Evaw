extends CharacterBody2D


#region vars

@onready var ap: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite

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

#endregion


func _physics_process(delta: float) -> void:
	# Waveforms
	forms()
	reset_uses()
	wave_spds()
	wave_dir(delta)
	
	# Movement
	gravity(delta)
	move(delta)
	jump()
	
	# Animations
	handle_anims()
	
	
	move_and_slide()


func forms() -> void:
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
		if Input.is_action_just_pressed("up") and is_on_floor():
			velocity.y = JUMP_VELOCITY
		
		# Jump Cut
		if Input.is_action_just_released("up") and velocity.y < 0:
			velocity.y = 0


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
