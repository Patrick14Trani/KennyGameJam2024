extends Node

var ghost = preload("res://Prefabs/ghost.tscn")
var chest = preload("res://Prefabs/chest.tscn")
var cyclops = preload("res://Prefabs/cyclops.tscn")
var spider = preload("res://Prefabs/spider.tscn")
var bat = preload("res://Prefabs/bat.tscn")
var rat = preload("res://Prefabs/rat.tscn")
var slime = preload("res://Prefabs/slime.tscn")
var evilWizard = preload("res://Prefabs/evil_wizard.tscn")
var crab = preload("res://Prefabs/crab.tscn")
var healthPotion = preload("res://Prefabs/health_potion.tscn")
var lightningPotion = preload("res://Prefabs/lightningUpgrade.tscn")
var waveNumber = 1
var enemiesSpawned = 1
var enemiesArray = []
var waveTimerReady = false
var enemiesReady = false

var playerSpeedUpgradeCost = 1
var playerDamageUpgradeCost = 1
var playerHealthUpgradeCost = 1
var rotationSpeedUpgradeCost = 1
var playerSpeed = 0
var playerDamage = 0
var playerHealth = 0
var rotationSpeed = 0
var points = 3
#var enemies = [ghost, chest, cyclops, spider, bat, rat, slime, evilWizard, crab]
var enemies = [spider, bat, rat]

@onready var wavePause_menu = $WavePauseMenu
@onready var pause_menu = $PauseMenu
@onready var pause_resume = $PauseMenu/MarginContainer/VBoxContainer/Resume
@onready var defeat_menu = $Defeat
@onready var victory_menu = $Victory
@onready var victory_restart = $Victory/MarginContainer/VBoxContainer/Restart

var paused = false

func _ready():
	Engine.time_scale = 1

func _process(_delta):
	if Input.is_action_just_pressed("Pause"):
		pauseMenu()
	if $Enemies.get_children().size() > 0:
		enemiesReady = false
	else:
		enemiesReady = true
	if waveTimerReady && enemiesReady:
		waveMenu()
		waveTimerReady = false

func pauseMenu():
	if !defeat_menu.visible:
		if paused:
			pause_menu.hide()
			Engine.time_scale = 1
		else:
			pause_menu.show()
			pause_resume.grab_focus()
			Engine.time_scale = 0
			
		paused = !paused

func _on_spawn_timer_timeout():
	for n in enemiesSpawned:
		var enemy = enemies[randi() % enemies.size()]
		var enemyInit = enemy.instantiate()
		enemyInit.player1 = get_node("Barb")
		enemyInit.player2 = get_node("Mage")
	
		var area1 = $EnemySpawnAreas/ReferenceRect1
		var area2 = $EnemySpawnAreas/ReferenceRect2
		var area3 = $EnemySpawnAreas/ReferenceRect3
		var areas = [area1, area2, area3]
		var area = areas[randi() % areas.size()]
		var positionInRect = area.position + Vector2(randf() * area.size.x, randf() * area.size.y)
		enemyInit.position = positionInRect
		$Enemies.add_child(enemyInit)
	
func _on_health_potion_spawn_timer_timeout():
	var health = healthPotion.instantiate()
	health.playerCont = get_node("PlayerController")
	
	var area = $ConsumablesSpawnArea/ReferenceRect
	var positionInRect = area.position + Vector2(randf() * area.size.x, randf() * area.size.y)
	health.position = positionInRect
	add_child(health)

func _on_lightning_spawn_timer_timeout():
	var lightning = lightningPotion.instantiate()
	lightning.playerCont = get_node("PlayerController")
	
	var area = $ConsumablesSpawnArea/LightningSpawn
	lightning.position = area.position + Vector2(randf() * area.size.x, randf() * area.size.y)
	add_child(lightning)

func _on_victory_timer_timeout():
	Engine.time_scale = 0
	victory_menu.show()
	victory_restart.grab_focus()

func _on_wave_timer_timeout():
	var enemyTimer = $SpawnTimer
	enemyTimer.paused = true
	var healthpotTimer = $HealthPotionSpawnTimer
	healthpotTimer.paused = true
	var lightningpotTimer = $LightningSpawnTimer
	lightningpotTimer.paused = true
	
	#TODO upgrade screen
	waveTimerReady = true

func waveMenu():
	var victoryTimer = $VictoryTimer
	victoryTimer.paused = true
	wavePause_menu.show()
	wavePause_menu.get_node("MarginContainer2/VBoxContainer/Resume").grab_focus()
	
func nextWave():
	points += 3
	waveNumber += 1
	var waveLabel = get_node("WaveLabel")
	waveLabel.set_text("Wave: " + str(waveNumber))
	wavePause_menu.hide()
	
	var enemyTimer = $SpawnTimer
	if enemyTimer.wait_time > .1:
		enemyTimer.wait_time -= .1
	else:
		enemyTimer.wait_time = 1
		enemiesSpawned += 1
	enemyTimer.paused = false
	
	#add enemies to spawn list
	#var enemies = [ghost, chest, cyclops, spider, bat, rat, slime, evilWizard, crab]
	if waveNumber == 3:
		enemies.append(crab)
	elif waveNumber == 4:
		enemies.append(slime)
	elif waveNumber == 5:
		enemies.append(chest)
	elif waveNumber == 6:
		enemies.append(ghost)
	elif waveNumber == 7:
		enemies.append(cyclops)
	elif waveNumber == 8:
		enemies.append(evilWizard)
	
	var healthpotTimer = $HealthPotionSpawnTimer
	healthpotTimer.paused = false
	var lightningpotTimer = $LightningSpawnTimer
	lightningpotTimer.paused = false
	var victoryTimer = $VictoryTimer
	victoryTimer.paused = false
	
	var waveTimer = $WaveTimer
	waveTimer.start()
	
func buyPlayerSpeed():
	print("Bought speed upgrade for: " + str(playerSpeedUpgradeCost))
	if points >= playerSpeedUpgradeCost:
		points -= playerSpeedUpgradeCost
		playerSpeedUpgradeCost += 1
		playerSpeed += 20
		$Barb.SPEED += 20
		$Mage.SPEED += 20


func buyPlayerDamage():
	print("Bought damage upgrade for: " + str(playerDamageUpgradeCost))
	if points >= playerDamageUpgradeCost:
		points -= playerDamageUpgradeCost
		playerDamageUpgradeCost += 1
		playerDamage += 5
		$Barb/Weapon.get_child(0).damage += 5
		$Mage/Weapon.get_child(0).damage += 5

func buyPlayerHealth():
	print("Bought health upgrade for: " + str(playerHealthUpgradeCost))
	if points >= playerHealthUpgradeCost:
		points -= playerHealthUpgradeCost
		playerHealthUpgradeCost += 1
		playerHealth += 10
		#healthBar.max_value = maxHealth
		#healthBar.value = maxHealth
		$Barb.playerController.maxHealth += 10
		$Barb.playerController.healthBar.max_value += 10
		$Barb.playerController.healthBar.value = $Barb.playerController.currentHealth
		#$Mage.playerController.maxHealth = playerHealth
		$Mage.playerController.maxHealth += 10
		$Mage.playerController.healthBar.max_value += 10
		$Mage.playerController.healthBar.value = $Mage.playerController.currentHealth

func buyRotationSpeed():
	print("Bought rotation speed upgrade for: " + str(rotationSpeedUpgradeCost))
	if points >= rotationSpeedUpgradeCost:
		points -= rotationSpeedUpgradeCost
		rotationSpeedUpgradeCost += 1
		rotationSpeed += 200
		$Barb/Weapon.rotation_speed += 100
		$Mage/Weapon.rotation_speed += 100
