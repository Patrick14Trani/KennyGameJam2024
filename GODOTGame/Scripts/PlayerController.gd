extends Node
signal hit
signal killed

@export var maxHealth : float = 100
@export var currentHealth : float
@export var score : int
@export var player1 : CharacterBody2D
@export var player2 : CharacterBody2D

var shieldIcon = "res://ArtAssets/Tiles/Shield.png"
var hasShield : bool = false
var isImmune : bool = false

var healthBar : ProgressBar

@onready var p1AnimPlay = player1.get_node("AnimationPlayer") as AnimationPlayer
@onready var p12AnimPlay = player2.get_node("AnimationPlayer") as AnimationPlayer

func _ready():
	currentHealth = maxHealth
	healthBar = get_node("CanvasLayer/HealthBar")
	_configHealthBar()
	score = 0

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
		if(currentHealth <= 0):
			kill()
		else:
			emit_signal("hit")
	elif(hasShield):
		print("SHIELDED")
		hasShield = false
		player1.get_node("StatusEffect").texture = null
		player2.get_node("StatusEffect").texture = null
		emit_signal("hit")
	
func heal(health):
	print("healing")
	currentHealth += health
	currentHealth = clamp(currentHealth, 0, maxHealth)
	healthBar.value = currentHealth
	print("Player health %s" % currentHealth)

func getShield():
	player1.get_node("StatusEffect").texture = shieldIcon
	player2.get_node("StatusEffect").texture = shieldIcon
	hasShield = true

func _on_immune_timer_timeout():
	print("No Longer Immune")
	isImmune = false
	p1AnimPlay.stop()
	p12AnimPlay.stop()

func _on_hit():
	print("Is Immune")
	isImmune = true
	p1AnimPlay.play("invulnerable")
	p12AnimPlay.play("invulnerable")
	$ImmuneTimer.start()
