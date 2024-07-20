extends CharacterBody2D

@export var speed: int
@export var player1: Node2D
@export var player2: Node2D
@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D

func _ready():
	makePath()

func _physics_process(delta: float) -> void:
	var dir = to_local(nav_agent.get_next_path_position()).normalized()
	velocity = dir * speed
	move_and_slide()

func makePath() -> void:
	var currentPosition = global_position
	var distanceToPlayer1 = currentPosition.distance_to(player1.global_position)
	var distanceToPlayer2 = currentPosition.distance_to(player2.global_position)
	
	if distanceToPlayer1 >= distanceToPlayer2:
		nav_agent.target_position = player1.global_position
	else:
		nav_agent.target_position = player2.global_position

func _on_timer_timeout():
	makePath()
