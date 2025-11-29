extends Area2D


#region var

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var you_have_one_new_message: AudioStreamPlayer = $YouHaveOneNewMessage
@onready var radio_in_the_vicinity: AudioStreamPlayer = $RadioInTheVicinity

var interactable = false
var interacting = false
var message_init_vol = 0
var vicinity_init_vol = 0

#endregion


func _ready() -> void:
	message_init_vol = you_have_one_new_message.volume_db - 24
	vicinity_init_vol = radio_in_the_vicinity.volume_db - 24


func _process(_delta: float) -> void:
	set_interacting()
	vol_set()


func set_interacting() -> void:
	if Input.is_action_just_pressed("interact") and interactable:
		if interacting == false:
			interacting = !interacting
			you_have_one_new_message.play()
		else:
			interacting = !interacting


func vol_set() -> void:
	you_have_one_new_message.volume_db = message_init_vol + Global.vol
	radio_in_the_vicinity.volume_db = vicinity_init_vol + Global.vol


func text() -> void:
	#match:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		interactable = true


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		interactable = false
		interacting = false


func _on_vicinity_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		radio_in_the_vicinity.play()


func _on_vicinity_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		radio_in_the_vicinity.stop()
