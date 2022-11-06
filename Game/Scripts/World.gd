extends Node



# Called when the node enters the scene tree for the first time.
func _ready():
	var mob = get_node("res://Scenes/spidor.tscn")
	add_child(mob)
