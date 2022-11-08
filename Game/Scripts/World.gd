extends Node


onready var Player = preload("res://Scenes/EntitiesScene/Warrior.tscn")
onready var Enemy = preload("res://Scenes/EntitiesScene/Enemy.tscn")


func _ready():
	var player = Player.instance()
	player.position.x = 256
	player.position.y = 960
	add_child(player)
	for i in range(0 , 4):
		get_mob($Path2D1/PathFollow2D)	
		get_mob($Path2D2/PathFollow2D)

func get_mob(node):
	var mob = Enemy.instance()
	var spawn_position = node
	
	spawn_position.offset = randi()
	mob.x_clamp = spawn_position.position.x
	mob.y_clamp = spawn_position.position.y
	mob.position = spawn_position.position
	
	add_child(mob)
	


