extends Node2D

@export var rotation_speed: int = 5
@export var player: Node2D
var battle_axe = preload("res://Prefabs/battle_axe.tscn")
var staff = preload("res://Prefabs/staff.tscn")

func _ready():
	if player.name == "Barb":
		var barbWeapon = battle_axe.instantiate()
		add_child(barbWeapon)
		
	if player.name == "Mage":
		var mageWeapon = staff.instantiate()
		add_child(mageWeapon)

func _process(_delta):
	rotation_degrees -= rotation_speed
