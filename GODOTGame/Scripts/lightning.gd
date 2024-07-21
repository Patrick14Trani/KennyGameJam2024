extends Area2D

@export var mage: CharacterBody2D
@export var barb: CharacterBody2D
@export var damage: float = 20

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	$Line2D.points[0] = mage.global_position
	$Line2D.points[1] = barb.global_position
	$CollisionShape2D.shape.a = $Line2D.points[0]
	$CollisionShape2D.shape.b = $Line2D.points[1]

func _on_body_entered(body):
	print("In laser body")
	if body.is_in_group("Enemies"):
		body.handle_hit(damage)
