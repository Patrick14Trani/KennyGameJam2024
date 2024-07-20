extends Area2D

@export var healingAmount: float = 20.0
@export var playerCont: Node

func _on_body_entered(body):
	if body.is_in_group("player"):
		playerCont.heal(healingAmount)
		print("You picked up %s health" % healingAmount)
		queue_free()
