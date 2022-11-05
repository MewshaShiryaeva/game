extends KinematicBody2D

var is_moving : bool
var speed = 45
var velocity = Vector2()
var destination = Vector2()
var start_pos = position

func _ready():
	wander()

func _process(delta):
	if is_moving:
		move_and_slide(velocity) 
	
func wander():
	randomize()
	var x = rand_range(start_pos.x - 150, start_pos.x + 150)
	var y = rand_range(start_pos.y - 150, start_pos.y + 150)
	
	destination = Vector2(x, y)
	
	
	velocity = (destination - position).normalized() * speed
	print(destination - position)
	is_moving = true
	
