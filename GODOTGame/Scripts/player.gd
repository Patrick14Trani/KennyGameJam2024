extends CharacterBody2D
signal gotHit(damage)

@export var UpControl = ""
@export var DownControl = ""
@export var RightControl = ""
@export var LeftControl = ""
@export var texturePath = ""
@export var SPEED = 100.0
@export var playerController: Node

var screenSize;

func _ready():
	$Sprite2D.texture = load(texturePath)
	screenSize = get_viewport()

func _physics_process(_delta):
	# Get the input direction and handle the movement/deceleration.
	velocity = get_directional_input().normalized() * SPEED
	move_and_slide()
	$Sprite2D.flip_h = velocity.x < 0
	for index in get_slide_collision_count():
		print("hit")
		var collision := get_slide_collision(index)
		var body = collision.get_collider()
		if(body.has_method("get_damage")):
			print("Attempting Damage")
			playerController.take_damage(body.damage)

func get_directional_input():
	var move_input_vector = Vector2(
		Input.get_action_strength(RightControl) - Input.get_action_strength(LeftControl),
		Input.get_action_strength(DownControl) - Input.get_action_strength(UpControl)
	)
	return move_input_vector;

func _on_area_2d_body_entered(body):
	print("Player has been run into")
	var node = body.get_parent() as Node
	if(node.has_method("get_damage")):
		print("Attempting Damage")
		playerController.take_damage(node.damage)

