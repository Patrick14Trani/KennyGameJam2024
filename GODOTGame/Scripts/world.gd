extends Node

var ghost = preload("res://Prefabs/ghost.tscn")
var chest = preload("res://Prefabs/chest.tscn")
var powerUp = preload("res://Prefabs/power_up.tscn")
var healthPotion = preload("res://Prefabs/health_potion.tscn")

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
	var enemies = [ghost, chest]
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
	add_child(enemyInit)

func _on_health_potion_spawn_timer_timeout():
	var health = healthPotion.instantiate()
	health.playerCont = get_node("PlayerController")
	
	var area = $ConsumablesSpawnArea/ReferenceRect
	var positionInRect = area.position + Vector2(randf() * area.size.x, randf() * area.size.y)
	health.position = positionInRect
	add_child(health)

func _on_victory_timer_timeout():
	Engine.time_scale = 0
	victory_menu.show()
	victory_restart.grab_focus()
