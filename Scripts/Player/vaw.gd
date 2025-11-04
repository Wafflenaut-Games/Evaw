extends CharacterBody2D


#region vars

const SPEED = 3000.0
const JUMP_VELOCITY = -200.0
const GRAV = 500.0
const F_GRAV = 750.0 # Fall gravity

var direction
var grav

#endregion


func _physics_process(delta: float) -> void:
	# Movement
	gravity(delta)
	move(delta)
	jump()
	
	
	move_and_slide()


func gravity(delta) -> void:
	# Set gravity
	if is_falling():
		grav = F_GRAV
	else:
		grav = GRAV
	
	# Apply gravity
	if not is_on_floor():
		velocity.y += GRAV * delta


func move(delta) -> void:
	direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED * delta
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)


func jump() -> void:
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	# Jump Cut
	if Input.is_action_just_released("jump") and velocity.y < 0:
		velocity.y = 0


func is_jumping() -> bool:
	if velocity.y < 0:
		return true
	else:
		return false


func is_falling() -> bool:
	if velocity.y > 0:
		return true
	else:
		return false
