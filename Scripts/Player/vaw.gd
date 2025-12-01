extends CharacterBody2D


#region vars

@onready var ap: AnimatedSprite2D = $AnimatedSprite2D
@onready var norm_col: CollisionShape2D = $NormCol
@onready var wave_col_check: Area2D = $WaveColCheck
@onready var no_soft_lock: Area2D = $NoSoftLock
@onready var respawn_point: Node2D = $"../Respawn"
@onready var level_titles: AnimatedSprite2D = $LevelTitles
@onready var transitions_layer: CanvasLayer = $Camera/TransitionsLayer
@onready var transitions: AnimatedSprite2D = $Camera/TransitionsLayer/Transitions
@onready var sensor_checker: Area2D = $SensorChecker
@onready var coyote_timer: Timer = $"Timers/Jump Timers/CoyoteTimer"
@onready var j_buffer_timer: Timer = $"Timers/Jump Timers/JBufferTimer"
@onready var dir_choose_timer: Timer = $Timers/DirChooseTimer
@onready var soft_lock_timer: Timer = $Timers/SoftLockTimer
@onready var death_timer: Timer = $Timers/DeathTimer
@onready var respawn_timer: Timer = $Timers/RespawnTimer
@onready var level_title_timer: Timer = $Timers/LevelTitleTimer
@onready var transition_timer: Timer = $Timers/TransitionTimer
@onready var exit_timer: Timer = $Timers/ExitTimer
@onready var ground_checker_l: RayCast2D = $ground_checkerL
@onready var ground_checker_r: RayCast2D = $ground_checkerR
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var walking: AudioStreamPlayer = $SFX/walking
@onready var switch_lume: AudioStreamPlayer = $SFX/SwitchLume
@onready var switch_sine: AudioStreamPlayer = $SFX/SwitchSine
@onready var switch_lume_2: AudioStreamPlayer = $SFX/SwitchLume2
@onready var switch_sine_2: AudioStreamPlayer = $SFX/SwitchSine2
@onready var tentative_jump: AudioStreamPlayer = $SFX/Tentativejump
@onready var death_sfx: AudioStreamPlayer = $SFX/Death
@onready var hit_grnd: AudioStreamPlayer = $SFX/HitGround
@onready var walking_particle: GPUParticles2D = $WalkingParticle
@onready var hitgroundparticle: GPUParticles2D = $hitgroundparticle
@onready var groundhittimer: Timer = $hitgroundparticle/groundhittimer
@onready var under: Node2D = $SFX/Under



const SPEED = 3000.0
const SINE_SPD_1 = 2200.0
const SINE_SPD_2 = 2400.0
const SINE_SPD_3 = 3500.0
const LUME_SPD_1 = 4000.0
const LUME_SPD_2 = 5000.0
const LUME_SPD_3 = 6000.0
const DIA_SINE_SPD_1 = SINE_SPD_1/sqrt(2)
const DIA_SINE_SPD_2 = SINE_SPD_2/sqrt(2)
const DIA_SINE_SPD_3 = SINE_SPD_3/sqrt(2)
const DIA_LUME_SPD_1 = LUME_SPD_1/sqrt(2)
const DIA_LUME_SPD_2 = LUME_SPD_2/sqrt(2)
const DIA_LUME_SPD_3 = LUME_SPD_3/sqrt(2)
const JUMP_VELOCITY = -160.0
const GRAV = 500.0
const W_GRAV = 300.0 # Underwater gravity
const F_GRAV = 600.0 # Fall gravity
const F_W_GRAV = 350.0 # Underwater fall gravity
const MAX_VEL = 10000.0


var direction
var grav
var spd
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
var soft_lock_override = false
var moused_dir = false
var soft_lock_timer_started = false
var inactive = true
var level_begun = false
var walking_playing
var hit_ground = false
var rand_switch = randi_range(1, 2)

var walk_init_vol = 0
var switch_init_vol = 0
var jump_init_vol = 0
var hit_grnd_init_vol = 0
var death_init_vol = 0

var james_music = false
var gwyn_music = false
var mateo_music = false
var roman_music = false

#endregion


func _ready() -> void:
	walk_init_vol = walking.volume_db - 24
	switch_init_vol = switch_lume.volume_db - 24
	jump_init_vol = tentative_jump.volume_db - 24
	hit_grnd_init_vol = hit_grnd.volume_db - 24
	death_init_vol = death_sfx.volume_db - 24
	level_titles.visible = true


func _physics_process(delta: float) -> void:
	# Always run
	level_begin()
	stop_sfx()
	
	credits_music()
	
	# Only while active
	if not inactive:
		# Waveforms
		formshift()
		form_collision()
		reset_uses()
		wave_spds(delta)
		wave_direction()
		
		# Movement
		gravity(delta)
		move(delta)
		max_vel(delta)
		jump()
		jump_buffer()
		coyote_time_set()
		
		# Other
		sensor_collision()
		disable_raycasts()
		restart()
		diff_dir_timer()
		
		# Animations/SFX
		handle_sfx()
		handle_anims()
		walking_particles()
		
		move_and_slide()


func level_begin() -> void:
	if level_begun == false:
		level_titles.play("%s" % Global.level)
		level_title_timer.start()
		level_begun = true


func formshift() -> void:
	# Switching to waveform
	# Mouse controls
	if Input.is_action_just_pressed("sine_m") and sine_used == false:
		$Camera.shake = true
		shockwave()
		moused_dir = true
		Global.vaw_form = "sine"
		wave_dir = ""
		sine_used = true
		velocity = Vector2(0, 0)
		dir_choose_timer.start()
		transforming = true
		
		if rand_switch == 1:
			switch_sine.play()
			rand_switch = randi_range(1, 2)
		elif rand_switch == 2:
			switch_sine_2.play()
			rand_switch = randi_range(1, 2)
	if Input.is_action_just_pressed("lume_m") and lume_used == false:
		$Camera.shake = true
		shockwave()
		moused_dir = true
		Global.vaw_form = "lume"
		wave_dir = ""
		lume_used = true
		velocity = Vector2(0, 0)
		dir_choose_timer.start()
		transforming = true
		
		if rand_switch == 1:
			switch_lume.play()
			rand_switch = randi_range(1, 2)
		elif rand_switch == 2:
			switch_lume_2.play()
	
	# Keyboard controls
	if Input.is_action_just_pressed("sine") and sine_used == false:
		$Camera.shake = true
		shockwave()
		moused_dir = false
		Global.vaw_form = "sine"
		wave_dir = ""
		sine_used = true
		velocity = Vector2(0, 0)
		dir_choose_timer.start()
		transforming = true
		
		if rand_switch == 1:
			switch_sine.play()
			rand_switch = randi_range(1, 2)
		elif rand_switch == 2:
			switch_sine_2.play()
	elif Input.is_action_just_pressed("lume") and lume_used == false:
		$Camera.shake = true
		switch_lume.play()
		shockwave()
		moused_dir = false
		Global.vaw_form = "lume"
		wave_dir = ""
		lume_used = true # @kadaiadak bro u forgot this line :sob:
		velocity = Vector2(0, 0)
		dir_choose_timer.start()
		transforming = true
		
		if rand_switch == 1:
			switch_lume.play()
			rand_switch = randi_range(1, 2)
		elif rand_switch == 2:
			switch_lume_2.play()
	
	
	# Revert to normal or start death in soft lock buffer
	if not soft_lock_override:
		if Global.vaw_form == "sine":
			if (not Input.is_action_pressed("sine") and not moused_dir) or (not Input.is_action_pressed("sine_m") and moused_dir):
				Global.vaw_form = "norm"
				wave_dir = ""
				sine_used = true
				velocity = Vector2(0, 0)
		elif Global.vaw_form == "lume":
			if (not Input.is_action_pressed("lume") and not moused_dir) or (not Input.is_action_pressed("lume_m") and moused_dir):
				Global.vaw_form = "norm"
				wave_dir = ""
				lume_used = true
				velocity = Vector2(0, 0)
	else:
		if Global.vaw_form == "norm":
			if soft_lock_timer_started == false:
				soft_lock_timer.start()
				soft_lock_timer_started = true


func form_collision() -> void:
	if Global.vaw_form == "norm":
		norm_col.disabled = false
		no_soft_lock.collision_mask = 0b00001110
		wave_col_check.collision_mask = 0b00000000
	elif Global.vaw_form == "sine":
		norm_col.disabled = true
		no_soft_lock.collision_mask = 0b00000110
		wave_col_check.collision_mask = 0b00001001
	elif Global.vaw_form == "lume":
		norm_col.disabled = true
		no_soft_lock.collision_mask = 0b00001010
		wave_col_check.collision_mask = 0b00000101


func reset_uses() -> void:
	if is_grounded() and Global.vaw_form == "norm":
		sine_used = false
		lume_used = false


func wave_spds(delta) -> void:
	# Check for diagonal
	if wave_dir.length() > 1:
		wave_dia = true
	else:
		wave_dia = false
	
	# Set speeds
	if Global.vaw_form == "sine":
		if not wave_dia:
			if Global.difficulty == 1:
				spd = SINE_SPD_1
			elif Global.difficulty == 2:
				spd = SINE_SPD_2
			elif Global.difficulty == 3:
				spd = SINE_SPD_3
		else:
			if Global.difficulty == 1:
				spd = DIA_SINE_SPD_1
			elif Global.difficulty == 2:
				spd = DIA_SINE_SPD_2
			elif Global.difficulty == 3:
				spd = DIA_SINE_SPD_3
	elif Global.vaw_form == "lume":
		if not wave_dia:
			if Global.difficulty == 1:
				spd = LUME_SPD_1
			elif Global.difficulty == 2:
				spd = LUME_SPD_2
			elif Global.difficulty == 3:
				spd = LUME_SPD_3
		else:
			if Global.difficulty == 1:
				spd = DIA_LUME_SPD_1
			elif Global.difficulty == 2:
				spd = DIA_LUME_SPD_2
			elif Global.difficulty == 3:
				spd = DIA_LUME_SPD_3
	
	# Apply speed
	if not Global.vaw_form == "norm":
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
			wave_dir = "u"
			no_y_wdir = false
		elif Input.is_action_pressed("down"):
			awaiting_dir = false
			wave_dir = "d"
			no_y_wdir = false
		else:
			no_y_wdir = true
		if Input.is_action_pressed("left"):
			awaiting_dir = false
			wave_dir = "l"
			no_x_wdir = false
		elif Input.is_action_pressed("right"):
			awaiting_dir = false
			wave_dir = "r"
			no_x_wdir = false
		else:
			no_x_wdir = true
	
	# Default if no directional input
	if no_x_wdir and no_y_wdir:
		awaiting_dir = false
		wave_dir = "r"
		no_x_wdir = false
		no_y_wdir = false


func gravity(delta) -> void:
	if Global.vaw_form == "norm":
		# Set gravity
		if Global.water_lvl:
			if is_falling():
				grav = F_W_GRAV
			else:
				grav = W_GRAV
		else:
			if is_falling():
				grav = F_GRAV
			else:
				grav = GRAV
			
		
		# Apply gravity
		if not is_on_floor():
			velocity.y += grav * delta


func diff_dir_timer() -> void:
	if Global.difficulty == 1:
		dir_choose_timer.wait_time = 0.5
	elif Global.difficulty == 2:
		dir_choose_timer.wait_time = 0.25
	elif Global.difficulty == 3:
		dir_choose_timer.wait_time = 0.125


func move(delta) -> void:
	if Global.vaw_form == "norm":
		direction = Input.get_axis("left", "right")
		if direction:
			velocity.x = direction * SPEED * delta
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)


func max_vel(delta) -> void:
	if velocity.y >= MAX_VEL * delta:
		if Global.difficulty == 1:
			velocity.y = MAX_VEL * delta * 0.75
		elif Global.difficulty == 2:
			velocity.y = MAX_VEL * delta * 1
		elif Global.difficulty == 3:
			velocity.y = MAX_VEL * delta * 1.33


func jump() -> void:
	if Global.vaw_form == "norm":
		# Jump
		if (Input.is_action_just_pressed("jump") or jump_buffering) and (is_on_floor() or coyote_time):
			velocity.y = JUMP_VELOCITY
			coyote_time = false
			jump_buffering = false
			tentative_jump.play()
		
		# Jump Cut
		if Input.is_action_just_released("jump") and velocity.y < 0:
			velocity.y = lerp(velocity.y, 0.0, 0.5)


func coyote_time_set() -> void:
	if is_on_floor() and not is_jumping():
		coyote_timer.start()
		coyote_time = true


func jump_buffer() -> void:
	if not is_on_floor() and not coyote_time and (Input.is_action_just_pressed("up") or Input.is_action_just_pressed("jump")):
		jump_buffering = true
		j_buffer_timer.start()


func is_jumping() -> bool:
	if velocity.y < 0 and Global.vaw_form == "norm":
		return true
	else:
		return false


func is_falling() -> bool:
	if velocity.y > 0 and Global.vaw_form == "norm":
		hit_ground = false
		return true
	else:
		return false


func is_grounded() -> bool:
	if ground_checker_l.is_colliding() or ground_checker_r.is_colliding():
		if not hit_ground:
			hit_grnd.play()
			hitgroundparticle.emitting = true
			groundhittimer.start()
			#easy find eeeeee
			hit_ground = true
		return true
	else:
		return false


func get_mouse_direction() -> void:
	var direction_vector = get_global_mouse_position() - global_position
	var angle_radians = direction_vector.angle()
	var angle_degrees = rad_to_deg(angle_radians)
	
	if angle_degrees > -45 and angle_degrees < 45:
		wave_dir = "r"
	elif angle_degrees < -45 and angle_degrees > -135:
		wave_dir = "u"
	elif angle_degrees > 45 and angle_degrees < 135:
		wave_dir = "d"
	else:
		wave_dir = "l"


func death() -> void:
	if not Global.dying:
		Global.death_count += 1
		Global.dying = true
		inactive = true
		ap.rotation_degrees = 0
		ap.play("die%s" % Global.water_lvl)
		death_sfx.play()
		death_timer.start()


func respawn() -> void:
	Global.dying = false
	Global.respawning = true
	position = respawn_point.position
	inactive = true
	ap.play("revive%s" % Global.water_lvl)
	respawn_timer.start()


func restart() -> void:
	if Input.is_action_just_pressed("restart"):
		death()


func sensor_collision() -> void:
	var areas = sensor_checker.get_overlapping_areas()
	
	for area in areas:
		if area.is_in_group("sound_sensor") and Global.vaw_form == "sine":
			area.get_parent().activate()
		if area.is_in_group("light_sensor") and Global.vaw_form == "lume":
			area.get_parent().activate()
		if area.is_in_group("feather"):
			area.get_parent().collect(self)


func shockwave() -> void:
	animation_player.play("shcokawave")


func disable_raycasts() -> void:
	if Global.vaw_form != "norm":
		ground_checker_l.enabled = false
		ground_checker_r.enabled = false
	else:
		ground_checker_l.enabled = true
		ground_checker_r.enabled = true


func walking_particles() -> void:
	if is_on_floor() and velocity.x != 0:
		walking_particle.emitting = true
	else:
		walking_particle.emitting = false


func stop_sfx() -> void:
	if Global.paused:
		walking.stop()


func handle_sfx() -> void:
	if Global.vaw_form == "norm" and is_grounded() and direction:
		if not walking.playing:
			walking.play()
	else:
		walking.stop()


func handle_anims() -> void:
	# Sprite Transformations
	if Global.vaw_form == "norm":
		if direction > 0:
			ap.flip_h = false
		elif direction < 0:
			ap.flip_h = true
		
		ap.rotation_degrees = 0
	else:
		# Waves
		if wave_dir == "ur":
			ap.rotation_degrees = 0
		elif wave_dir == "ul":
			ap.rotation_degrees = -90
		elif wave_dir == "dr":
			ap.rotation_degrees = 90
		elif wave_dir == "dl":
			ap.rotation_degrees = 180
		if wave_dir == "r":
			ap.rotation_degrees = 0
		elif wave_dir == "l":
			ap.rotation_degrees = 180
		elif wave_dir == "d":
			ap.rotation_degrees = 90
		elif wave_dir == "u":
			ap.rotation_degrees = -90
		
		ap.flip_h = false
	
	
	# Animations
	if Global.vaw_form == "norm":
		if direction:
			ap.play("run%s" % Global.water_lvl)
		else:
			if is_falling():
				ap.play("fall%s" % Global.water_lvl)
			else:
				ap.play("idle%s" % Global.water_lvl)
	elif Global.vaw_form == "sine":
		if transforming:
			ap.play("to_sine")
		else:
			if wave_dia:
				ap.play("sine_dia")
			else:
				ap.play("sine_card")
	elif Global.vaw_form == "lume":
		if transforming:
			ap.play("to_lume")
		else:
			if wave_dia:
				ap.play("lume_dia")
			else:
				ap.play("lume_card")


func _on_coyote_timer_timeout() -> void:
	coyote_time = false


func _on_j_buffer_timer_timeout() -> void:
	jump_buffering = false


func _on_dir_choose_timer_timeout() -> void:
	transforming = false
	
	if moused_dir:
		get_mouse_direction()
	else:
		awaiting_dir = true


func _on_soft_lock_timer_timeout() -> void:
	if soft_lock_override:
		death()
		soft_lock_override = false
		soft_lock_timer_started = false


func _on_wave_col_check_body_entered(_body: Node2D) -> void:
	if not is_on_floor():
		Global.vaw_form = "norm"
		wave_dir = ""
		wave_dia = false


func _on_no_soft_lock_body_entered(body: Node2D) -> void:
	if body.name.to_lower() == "tileset":
		soft_lock_override = true


func _on_no_soft_lock_body_exited(_body: Node2D) -> void:
	soft_lock_override = false


func _on_hitbox_area_entered(_area: Area2D) -> void:
	death()


func _on_death_timer_timeout() -> void:
	respawn()


func _on_respawn_timer_timeout() -> void:
	Global.respawning = false
	inactive = false


func _on_level_title_timer_timeout() -> void:
	level_titles.visible = false
	transitions_layer.visible = true
	transitions.play("open")
	transition_timer.start()


func _on_transition_timer_timeout() -> void:
	inactive = false
	Global.is_transitioning = false


func _on_groundhittimer_timeout() -> void:
	hitgroundparticle.emitting = false


func credits_music():
	if Global.level == 10:
		var areas = $Hitbox.get_overlapping_areas()
		
		for area in areas:
			if area.is_in_group("james"):
				james_music = true
				gwyn_music = false
				mateo_music = false
				roman_music = false
			if area.is_in_group("gwyn"):
				gwyn_music = true
				james_music = false
				mateo_music = false
				roman_music = false
			if area.is_in_group("teo"):
				mateo_music = true
				james_music = false
				gwyn_music = false
				roman_music = false
			if area.is_in_group("roman"):
				roman_music = true
				james_music = false
				gwyn_music = false
				mateo_music = false
	
	if james_music:
		pass
	
