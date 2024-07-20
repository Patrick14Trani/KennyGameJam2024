extends CharacterBody2D

@export var speed: int = 50
@export var player1: Node2D
@export var player2: Node2D
@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D
@export var damage: float = 10
@export var health: float = 20

var plEnemyDeathParticles := preload("res://Particles/enemy_death.tscn")
var plFloatingText := preload("res://Particles/floating_text.tscn")

func _ready():
	set_physics_process(false)
	call_deferred("enemies_setup")

func enemies_setup():
	await get_tree().physics_frame
	set_physics_process(true)

func _physics_process(_delta: float) -> void:
	var dir = to_local(nav_agent.get_next_path_position()).normalized()
	velocity = dir * speed
	move_and_slide()

func makePath() -> void:
	var currentPosition = global_position
	var distanceToPlayer1 = currentPosition.distance_to(player1.global_position)
	var distanceToPlayer2 = currentPosition.distance_to(player2.global_position)
	
	if distanceToPlayer1 <= distanceToPlayer2:
		nav_agent.target_position = player1.global_position
	else:
		nav_agent.target_position = player2.global_position

func get_damage():
	return damage

func _on_timer_timeout():
	makePath()

func handle_hit(damageDealt):
	print("enemy hit")
	health -= damageDealt
	var text := plFloatingText.instantiate()
	text.amount = damageDealt
	text.global_position = global_position
	get_tree().current_scene.add_child(text)
	if health <= 0:
		kill()

func kill():
	print("enemy killed")
	var effect := plEnemyDeathParticles.instantiate()
	effect.global_position = global_position
	get_tree().current_scene.add_child(effect)
	queue_free()
