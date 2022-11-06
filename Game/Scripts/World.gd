extends Node

var Mob = preload("res://Scenes/EntitiesScene/spidor.tscn")
var Player = preload("res://Scenes/EntitiesScene/Player.tscn")

func _ready():
	var player = Player.instance()
	player.position.x = 256
	player.position.y = 960
	add_child(player)
	for i in range(0 ,10):
		var mob = Mob.instance()
		var spawn_position = $Path2D/PathFollow2D
		spawn_position.offset = randi()
		mob.position = spawn_position.position
		add_child(mob)
	
