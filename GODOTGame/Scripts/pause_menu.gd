extends Control

@onready var rootNode = get_tree().root.get_child(0)

func _on_resume_pressed():
	rootNode.pauseMenu()

func _on_main_menu_pressed():
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")
