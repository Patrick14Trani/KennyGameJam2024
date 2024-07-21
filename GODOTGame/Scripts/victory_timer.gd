extends Label

func _process(_delta):
	var timeLeft = "%.02f" % get_parent().time_left
	text = timeLeft
