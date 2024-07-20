extends Node2D
signal hit
signal killed

@export var maxHealth : float = 100
@export var currentHealth : float
@export var score : int
@export var mage : CharacterBody2D
@export var barb : CharacterBody2D

var shieldIcon = "res://ArtAssets/Tiles/Shield.png"
var hasShield : bool = false
var isImmune : bool = false
var islasering: bool = false
var laser = preload("res://Prefabs/laser.tscn")

var healthBar : ProgressBar

func _ready():
	currentHealth = maxHealth
	healthBar = get_node("CanvasLayer/HealthBar")
	_configHealthBar()
	score = 0

func _process(delta) -> void:
	if(islasering):
		print("FIRIN MY LASER")
		

func _configHealthBar():
	healthBar.max_value = maxHealth
	healthBar.value = maxHealth

func kill():
	pass

func take_damage(damage):
	if(!hasShield || !isImmune):
		print("taking damage")
		currentHealth -= damage
		currentHealth = clamp(currentHealth, 0, maxHealth)
		healthBar.value = currentHealth
		print("Player health %s" % currentHealth)
		if(currentHealth == 0):
			kill()
		else:
			emit_signal("hit")
	elif(hasShield):
		print("SHIELDED")
		hasShield = false
		mage.get_node("StatusEffect").texture = null
		barb.get_node("StatusEffect").texture = null
		emit_signal("hit")
	
func heal(health):
	print("healing")
	currentHealth += health
	currentHealth = clamp(currentHealth, 0, maxHealth)
	healthBar.value = currentHealth
	print("Player health %s" % currentHealth)

func getShield():
	mage.get_node("StatusEffect").texture = shieldIcon
	barb.get_node("StatusEffect").texture = shieldIcon
	hasShield = true

func _on_immune_timer_timeout():
	print("No Longer Immune")
	isImmune = false

func _on_laser_timer_timeout():
	print("No more laser time")
	islasering = false
	
func _on_hit():
	print("Is Immune")
	isImmune = true
	$ImmuneTimer.start()

func fireLaser():
	islasering = true;
	var laserInit = laser.instantiate()
	laserInit.mage = mage
	laserInit.barb = barb
	add_child(laserInit)
	$LaserTimer.start()

