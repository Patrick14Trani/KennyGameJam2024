extends Marker2D

@onready var label = $Label
var amount = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	label.set_text(str(amount))
	
	var tween := create_tween()
	tween.tween_property(self, 'scale', Vector2(1,1), 0.2).from_current().set_trans(tween.TRANS_LINEAR)
	tween.tween_property(self, 'scale', Vector2(0.1, 0.1), 0.7).from_current().set_trans(Tween.TRANS_LINEAR)
	
	await tween.finished
	self.queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


