extends Control

@onready var rootNode = get_tree().root.get_child(0)

func _on_resume_pressed():
	rootNode.nextWave()


func _on_buy_speed_pressed():
	rootNode.buyPlayerSpeed()


func _on_buy_health_pressed():
	rootNode.buyPlayerHealth()


func _on_buy_damage_pressed():
	rootNode.buyPlayerDamage()


func _on_buy_rotation_speed_pressed():
	rootNode.buyRotationSpeed()
