extends Node


onready var Player = preload("res://Scenes/EntitiesScene/Warrior.tscn")
onready var Spider = preload("res://Scenes/EntitiesScene/Spider.tscn")

func _process(delta):
	$CanvasLayer/TextureProgress.value = global.player_health

func _ready():	
	var player = Player.instance()
	player.position.x = 256
	player.position.y = 960
	add_child(player)
	for i in range(0 , 4):
		get_mob($Path2D1/PathFollow2D)	
		get_mob($Path2D2/PathFollow2D)
	get_health_bar()	
	
func get_mob(node):
	var mob = Spider.instance()
	var spawn_position = node
	spawn_position.offset = randi()
	mob.x_zone = spawn_position.position.x
	mob.y_zone = spawn_position.position.y
	mob.position = spawn_position.position
	mob.add_to_group("mobs")
	add_child(mob)


func get_mobs_group():
	var mobs_group = get_tree().get_nodes_in_group("mobs")
	print(mobs_group.size())

func get_health_bar():
	$CanvasLayer/TextureProgress.max_value = global.max_player_health

	
