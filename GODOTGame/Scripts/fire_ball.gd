extends Area2D

@export var speed = 2
#@export var target: CharacterBody2D

var target = null
var damage = null
var direction = null

func start(_target, _damage):
	target = _target.global_position
	damage = _damage

func _process(delta):
	var direction = global_position.direction_to(target).angle()
	rotation = move_toward(rotation, direction, delta)
	var velocity = Vector2(position.x * speed * delta, 0)
	translate(velocity)

func _on_body_entered(body):
	print("Struck Enemy")
	if body.is_in_group("Enemies"):
		body.handle_hit(damage)
		queue_free()
