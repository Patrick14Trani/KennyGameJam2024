extends Node
signal health_Updated(health)
signal killed

@export var maxHealth : float = 100
@export var currentHealth : float
var healthChange : float
@export var score : int

var healthBar : ProgressBar

func _ready():
	currentHealth = maxHealth
	healthChange = maxHealth
	healthBar = get_node("CanvasLayer/HealthBar")
	_configHealthBar()
	score = 0

func _configHealthBar():
	healthBar.max_value = maxHealth
	healthBar.value = maxHealth

func kill():
	pass

func take_damage(damage):
	print("taking damage")
	currentHealth -= damage
	currentHealth = clamp(currentHealth, 0, maxHealth)
	healthBar.value = currentHealth
	print("Player health %s" % currentHealth)
	if(currentHealth == 0):
		kill()


