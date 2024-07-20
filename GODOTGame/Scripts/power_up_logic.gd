extends Area2D
@export var itemName : String = ""
@export var itemTypes : Array = ["HealthPotion", "LaserBeam", "Shield", "DamageUp"]

var assetFormat = "res://ArtAssets/Tiles/%s.png"
var rng = RandomNumberGenerator.new()
var playerController

# Called when the node enters the scene tree for the first time.
func _ready():
	_configure_item()
	var asset = assetFormat % itemName
	$Sprite2D.texture = load(asset)
	playerController = get_parent().get_node("PlayerController")

func _configure_item():
	itemName = itemTypes.pick_random()

func ApplyHealthPotion():
	var healAmount = rng.randf_range(10, 40)
	playerController.heal(healAmount)

func ApplyShield():
	playerController.getShield()

func ApplyDamageUp():
	pass

func ApplyLaserBeam():
	pass

func _on_body_entered(body):
	print("pickupAreaEntered")
	if(body.name == "Barb" || body.name == "Mage"):
		match itemName:
			"HealthPotion":
				print("Health Potion Hit")
				ApplyHealthPotion()
			"LaserBeam":
				print("LASER LASER")
				playerController.fireLaser()
			"Shield":
				print("Shield Acquired")
				ApplyShield()
			"DamageUp":
				print("Damage Up Aquired")# Replace with function body.
		queue_free()
