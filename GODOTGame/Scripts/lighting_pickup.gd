extends Area2D

@export var playerCont: Node

func _on_body_entered(body):
	print("its laser time")
	if body.is_in_group("player") && !playerCont.hasLightning:
		playerCont.start_Lightning()
		queue_free()
