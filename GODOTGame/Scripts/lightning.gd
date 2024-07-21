extends Line2D

@export var mage: CharacterBody2D
@export var barb: CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	#for i in points.size() - 1:
		#var new_shape = CollisionShape2D.new()
		#$StaticBody2D.add_child(new_shape)
		#var segment = SegmentShape2D.new()
		#segment.a = points[i]
		#segment.b = points[i + 1]
		#new_shape.shape = segment

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	points[0] = mage.global_position
	points[1] = barb.global_position
