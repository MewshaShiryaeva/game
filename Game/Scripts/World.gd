extends Node

var Mob = preload("res://Scenes/EntitiesScene/spidor.tscn")


func _ready():
	for i in range(0 ,10):
		var mob = Mob.instance()
		mob.position.x = 500
		mob.position.y = 500
		add_child(mob)
	
