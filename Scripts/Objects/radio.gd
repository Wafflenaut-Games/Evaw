extends Area2D


#region vars

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var you_have_one_new_message: AudioStreamPlayer = $YouHaveOneNewMessage
@onready var radio_in_the_vicinity: AudioStreamPlayer = $RadioInTheVicinity
@onready var radio_text: Label = $"../Vaw/RadioText"
@onready var typingtimer: Timer = $typingtimer


var interactable = false
var interacting = false

@export var number: int

var dialogue: Array = [
	"In a world filled with echoes and light
	A power produced, impending blight
	The nation's death born from a crave
	As the final wielder exits the cave".to_upper(),
	
	"The shift was made so carelessly
	As frequency met frequency
	Cities shattered, earth in pain
	Now fate was set, escape in vain".to_upper(),
	
	"The lights went out as power stopped
	The flames of self from color sought
	Corrupted by a selfish whim
	As lives around his own went dim".to_upper(),
	
	"Waves
	Waves enslaved in horror
	Waves surpassed the requirements
	From reckless testing persistence
	The Last Wave tore the world apart
	As some were sent back to the start
	The remaining survivors tried to defend
	This last attempt had sealed the end".to_upper(),
	
	"ONE
	THERE WAS ONE WHO FLED
	REMAINS SO CLOSE
	THE NEARING END ".to_upper()
]

#endregion


func _process(_delta: float) -> void:
	set_interacting()
	text()
	
	if radio_text.visible == false:
		radio_text.visible_characters = 0


func set_interacting() -> void:
	if Input.is_action_just_pressed("interact") and interactable:
		if interacting == false:
			interacting = !interacting
			you_have_one_new_message.play()
		else:
			interacting = !interacting


func text() -> void:
	if interacting:
		radio_text.visible = true
		
		radio_text.text = dialogue[number - 1]
	else:
		radio_text.text = ""
		radio_text.visible = false


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


func _on_typingtimer_timeout() -> void:
	if radio_text.visible == true:
		radio_text.visible_characters += 1
