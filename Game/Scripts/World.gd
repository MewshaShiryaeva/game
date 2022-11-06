extends Node

var Mob = preload("res://Scenes/EntitiesScene/spidor.tscn")
var Player = preload("res://Scenes/EntitiesScene/Player.tscn")

func _ready():
	var player = Player.instance()
	player.position.x = 300
	player.position.y = 300
	add_child(player)
	for i in range(0 ,10):
		var mob = Mob.instance()
		mob.position.x = 500
		mob.position.y = 500
		add_child(mob)
	
