extends Area2D

func _on_body_entered(_body):
	print("You died.")
	Engine.time_scale = 0.5
	
	var timer = get_node("Timer") as Timer
	timer.start()
	
func _on_timer_timeout():
	Engine.time_scale = 1.0
	get_tree().reload_current_scene()
