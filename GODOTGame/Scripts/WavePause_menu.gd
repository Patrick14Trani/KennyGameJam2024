extends Control

@onready var rootNode = get_tree().root.get_child(0)
@onready var playerSpeedButton = get_node("MarginContainer/VBoxContainer/BuySpeed")
@onready var playerHealthButton = get_node("MarginContainer/VBoxContainer/BuyHealth")
@onready var playerDamageButton = get_node("MarginContainer/VBoxContainer/BuyDamage")
@onready var rotationSpeedButton = get_node("MarginContainer/VBoxContainer/BuyRotationSpeed")
@onready var pointsLabel = get_node("MarginContainer/VBoxContainer/Label")

func _on_resume_pressed():
	rootNode.nextWave()


func _on_buy_speed_pressed():
	rootNode.buyPlayerSpeed()
	playerSpeedButton.set_text("Upgrade Player Speed: " + str(rootNode.playerSpeedUpgradeCost))
	pointsLabel.set_text("Points: " + str(rootNode.points))

func _on_buy_health_pressed():
	rootNode.buyPlayerHealth()
	playerHealthButton.set_text("Upgrade Player Health: " + str(rootNode.playerHealthUpgradeCost))
	pointsLabel.set_text("Points: " + str(rootNode.points))
	
func _on_buy_damage_pressed():
	rootNode.buyPlayerDamage()
	playerDamageButton.set_text("Upgrade Player Damage: " + str(rootNode.playerDamageUpgradeCost))
	pointsLabel.set_text("Points: " + str(rootNode.points))

func _on_buy_rotation_speed_pressed():
	rootNode.buyRotationSpeed()
	rotationSpeedButton.set_text("Upgrade Rotation Speed: " + str(rootNode.rotationSpeedUpgradeCost))
	pointsLabel.set_text("Points: " + str(rootNode.points))

func _on_hidden():
#var playerSpeedUpgradeCost = 0
#var playerDamageUpgradeCost = 0
#var playerHealthUpgradeCost = 0
#var rotationSpeedUpgradeCost = 0
	playerSpeedButton.set_text("Upgrade Player Speed: " + str(rootNode.playerSpeedUpgradeCost))
	playerDamageButton.set_text("Upgrade Player Damage: " + str(rootNode.playerDamageUpgradeCost))
	playerHealthButton.set_text("Upgrade Player Health: " + str(rootNode.playerHealthUpgradeCost))
	rotationSpeedButton.set_text("Upgrade Rotation Speed: " + str(rootNode.rotationSpeedUpgradeCost))
	pointsLabel.set_text("Points: " + str(3))
