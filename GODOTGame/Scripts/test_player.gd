extends CharacterBody2D

@export var UpControl = ""
@export var DownControl = ""
@export var RightControl = ""
@export var LeftControl = ""
@export var texturePath = ""
@export var SPEED = 100.0

var screenSize;

func _ready():
	$Sprite2D.texture = load(texturePath)
	screenSize = get_viewport()

func _physics_process(_delta):
	# Get the input direction and handle the movement/deceleration.
	velocity = get_directional_input().normalized() * SPEED
	move_and_slide()
	$Sprite2D.flip_h = velocity.x < 0

func get_directional_input():
	var move_input_vector = Vector2(
		Input.get_action_strength(RightControl) - Input.get_action_strength(LeftControl),
		Input.get_action_strength(DownControl) - Input.get_action_strength(UpControl)
	)
	return move_input_vector;