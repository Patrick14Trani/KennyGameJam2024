extends CharacterBody2D

@export var UpControl = ""
@export var DownControl = ""
@export var RightControl = ""
@export var LeftControl = ""
@export var texturePath = ""
@export var SPEED = 100.0
@export var playerController: Node

@export var projectile: PackedScene
@export var shootingSpeed: float = 5
@export var projectileDamage: float = 10
var canShoot: bool = true

var screenSize;

func _ready():
	$Sprite2D.texture = load(texturePath)
	screenSize = get_viewport()

func _physics_process(_delta):
	# Get the input direction and handle the movement/deceleration.
	velocity = get_directional_input().normalized() * SPEED
	move_and_slide()
	$Sprite2D.flip_h = velocity.x < 0
	# Detect enemies nearby if able to shoot
	if(canShoot):
		var bodies = $RangedAttackZone.get_overlapping_bodies()
		if(bodies.size() > 0):
			var target = bodies[0]
			var distance = self.global_position.distance_squared_to(target.global_position)
			for body in bodies:
				var newDistance = self.global_position.distance_squared_to(body.global_position)
				if(newDistance < distance):
					distance = newDistance
					target = body
			print("Shooting")
			var shot = projectile.instantiate()
			shot.position = global_position
			shot.start(target, projectileDamage)
			get_parent().add_child(shot)
			canShoot = false
			$RangedAttack.start()

func get_directional_input():
	var move_input_vector = Vector2(
		Input.get_action_strength(RightControl) - Input.get_action_strength(LeftControl),
		Input.get_action_strength(DownControl) - Input.get_action_strength(UpControl)
	)
	return move_input_vector;

func _on_area_2d_body_entered(body):
	print("Hit")
	if(body.has_method("get_damage")):
		print("Attempting Damage")
		playerController.take_damage(body.damage)


func _on_ranged_attack_timeout():
	canShoot = true
