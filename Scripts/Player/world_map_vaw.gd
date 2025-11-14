extends CharacterBody2D


#region vars
const SPEED = 1000.0

var moving = false
var stopped = false
#endregion


func _physics_process(delta: float) -> void:
	move(delta)
	
	move_and_slide()


func move(delta) -> void:
	if not Global.lvl_selected:
		if Input.is_action_just_pressed("up") and Global.world_map_dirs.has("up"):
			velocity.y = -SPEED * delta
			moving = true
			Global.world_map_dirs = []
		elif Input.is_action_just_pressed("down") and Global.world_map_dirs.has("down"):
			velocity.y = SPEED * delta
			moving = true
			Global.world_map_dirs = []
		elif Input.is_action_just_pressed("left") and Global.world_map_dirs.has("left"):
			velocity.x = -SPEED * delta
			moving = true
			Global.world_map_dirs = []
		elif Input.is_action_just_pressed("right") and Global.world_map_dirs.has("right"):
			velocity.x = SPEED * delta
			moving = true
			Global.world_map_dirs = []
