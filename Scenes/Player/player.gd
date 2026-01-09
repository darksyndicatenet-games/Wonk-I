extends CharacterBody2D

@onready var player_health_bar: ProgressBar = $PlayerHealthBar
#work on game over screen
#main menu screen
#ending sceen credits
@onready var jump_timer: Timer = $JumpTimer
@onready var player_animation: AnimatedSprite2D = $PlayerAnimation

var player_is_jumping: bool = false

@export var speed := 250
var direction_x: float

func _ready() -> void:
	player_health_bar.value = Global.player_health

func apply_gravity():
	velocity.y += 10
	
	
func get_input():
	direction_x =  Input.get_axis("left","right")
	
	if Input.is_action_just_pressed("jump")  && player_is_jumping == false:
		velocity.y = -200
		player_is_jumping = true
		jump_timer.start()
		player_animation.play("Jump")
		print("jump")
	if Input.is_action_just_pressed("attack"):
		
		pass

func _physics_process(_delta: float) -> void:
	get_input()
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
	velocity.x = direction_x * speed
	apply_gravity()
	
	
	move_and_slide()


func player_take_damage(damage : int):
	Global.player_health -= damage
	print("Player health: "+ str(Global.player_health))
	player_health_bar.value = Global.player_health
	pass
	


func _on_jump_timer_timeout() -> void:
	player_is_jumping = false
	print("player_is_jumping return false")
