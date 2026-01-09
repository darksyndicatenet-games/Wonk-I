extends Area2D

@export var speed := 300
@export var damage := 10

var direction := Vector2.ZERO

func _ready():
	if direction == Vector2.ZERO:
		push_warning("Bullet direction is ZERO")

func _physics_process(delta):
	position += direction * speed * delta

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.player_take_damage(damage)
		print(damage)
		queue_free()
