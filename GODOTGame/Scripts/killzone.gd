extends Area2D

func _on_body_entered(body):
	print("You are dead bitch.")
	Engine.time_scale = 0.5
	var collider = body.get_node("CollisionShape2D")
	collider.queue_free()
	
	var timer = get_node("Timer") as Timer
	timer.start()
	
func _on_timer_timeout():
	Engine.time_scale = 1.0
	get_tree().reload_current_scene()
