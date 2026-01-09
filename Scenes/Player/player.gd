extends CharacterBody2D


var speed := 200
var direction_x: float

func apply_gravity():
	velocity.y += 10
	
	
func get_input():
	direction_x =  Input.get_axis("left","right")
	if Input.is_action_just_pressed("jump"):
		velocity.y = -200
		print("jump")

func _physics_process(_delta: float) -> void:
	get_input()
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
	velocity.x = direction_x * speed
	apply_gravity()
	move_and_slide()
