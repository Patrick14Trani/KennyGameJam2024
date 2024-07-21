extends Node

var ghost = preload("res://Prefabs/ghost.tscn")
var chest = preload("res://Prefabs/chest.tscn")
var powerUp = preload("res://Prefabs/power_up.tscn")
var healthPotion = preload("res://Prefabs/health_potion.tscn")
var lightningPotion = preload("res://Prefabs/lightningUpgrade.tscn")

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

func _on_lightning_spawn_timer_timeout():
	var lightning = lightningPotion.instantiate()
	lightning.playerCont = get_node("PlayerController")
	
	var area = $ConsumablesSpawnArea/LightningSpawn
	lightning.position = area.position + Vector2(randf() * area.size.x, randf() * area.size.y)
	add_child(lightning)
	
