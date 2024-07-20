extends Control

func _ready():
	$VBoxContainer/Start.grab_focus()

func _on_start_pressed():
	get_tree().change_scene_to_file("res://Scenes/desert.tscn")
	
func _on_controls_pressed():
	pass # Replace with function body.

func _on_quit_pressed():
	get_tree().quit()
