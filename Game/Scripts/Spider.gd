extends "res://Scripts/default_enemy.gd"

func _init():
	is_angry = true
	player_is_attacked = false
	staying = true
	speed = 45
	speed_atack = 1
	range_atack = 40
	damage = 1
	detection_area = 200

