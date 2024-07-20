extends Node

var ghost = preload("res://Prefabs/ghost.tscn")
var chest = preload("res://Prefabs/chest.tscn")

func _on_spawn_timer_timeout():
	var enemies = [ghost, chest]
	var enemy = enemies[randi() % enemies.size()]
	var enemyInit = enemy.instantiate()
	enemyInit.player1 = get_node("Barb")
	enemyInit.player2 = get_node("Mage")
	
	var area1 = $SpawnAreas/ReferenceRect1
	var area2 = $SpawnAreas/ReferenceRect2
	var area3 = $SpawnAreas/ReferenceRect3
	var areas = [area1, area2, area3]
	var area = areas[randi() % areas.size()]
	var positionInRect = area.position + Vector2(randf() * area.size.x, randf() * area.size.y)
	enemyInit.position = positionInRect
	add_child(enemyInit)
