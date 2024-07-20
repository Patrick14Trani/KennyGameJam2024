extends Line2D

var mage : CharacterBody2D
var barb : CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	set_point_position(0, mage.global_position)
	set_point_position(1, barb.global_position)
