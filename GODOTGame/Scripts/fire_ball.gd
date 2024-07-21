extends Area2D

@export var speed = 100
#@export var target: CharacterBody2D

var target = null
var damage = null
var direction = null

func start(_target, _damage):
	target = _target.global_position
	damage = _damage

func _process(delta):
	var direction = position.direction_to(target).angle()
	var velocity = Vector2(target.x, target.y).normalized()
	translate(velocity * speed * delta)

func _on_body_entered(body):
	print("Struck Enemy")
	if body.is_in_group("Enemies"):
		body.handle_hit(damage)
		queue_free()
