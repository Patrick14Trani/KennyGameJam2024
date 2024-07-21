extends Label

func _process(delta):
	var timeLeft = "%.02f" % get_parent().time_left
	text = timeLeft
