extends Area2D
signal hitPlayer
const BARB = "Barb"
const MAGE = "Mage"
@export var damage = 10

func _on_body_entered(body):
	#TODO: Fix this so the ghost can run into other objects and not attempt to harm them
	if(body.name == BARB || body.name == MAGE):
		print("ran into player")
		#collider.queue_free()
		#var timer = get_node("Timer") as Timer
		#timer.start()

func _on_timer_timeout():
	Engine.time_scale = 1.0
	get_tree().reload_current_scene()

