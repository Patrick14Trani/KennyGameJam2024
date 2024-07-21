extends Control

@onready var rootNode = get_tree().root.get_child(0)

func _on_resume_pressed():
	rootNode.nextWave()
