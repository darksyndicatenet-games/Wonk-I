extends CharacterBody2D

@onready var enemy_health_bar: ProgressBar = $EnemyHealthBar
@export var bullet_scene: PackedScene
@onready var shoot_point: Marker2D = $ShootPoint
@onready var shoot_timer: Timer = $ShootTimer
@export var shoot_cooldown := 1.5

var is_player_in_enemy_area = false

@export var enemy_health : float = 100
var player: CharacterBody2D
#enemy gives player damage
#enemy takes damage from player
#have enemy wander
#have enemy "shoot"?

@export var max_health := 100
var current_health := 0

func _ready():
	current_health = max_health
	player = get_tree().get_first_node_in_group("player")
	shoot_timer.wait_time = shoot_cooldown
	shoot_timer.start()

func enemy_take_damage(amount: int):
	current_health -= amount
	if current_health <= 0:
		die()

func die():
	queue_free()

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("attack") && is_player_in_enemy_area == true:
		enemy_health -= 10
		enemy_health_bar.value = enemy_health
		print("enemy health: "+ str(enemy_health))
	

func _on_shoot_timer_timeout() -> void:
	if player:
		shoot()

func shoot():
	var bullet = bullet_scene.instantiate()
	bullet.global_position = shoot_point.global_position
	
	var dir = (player.global_position - global_position).normalized()
	bullet.direction = dir
	
	get_parent().add_child(bullet)


func _on_enemy_damage_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		is_player_in_enemy_area = true
		print("player in enemy area")

func _on_enemy_damage_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		is_player_in_enemy_area = false
		print("player NOT in enemy area")
