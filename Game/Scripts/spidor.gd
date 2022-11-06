extends KinematicBody2D

var staying = true
var speed = 45
var velocity = Vector2()
var destination = Vector2()


func _process(delta):
	if velocity:
		move_and_slide(velocity)
	generate_destination()
			
func get_destination(dest):
	destination = dest
	velocity = (destination - position).normalized() * speed
	staying = false


func generate_destination():	
	if staying:
		randomize()
		var x = rand_range(position.x - 150, position.x + 150)
		var y = rand_range(position.y - 150, position.y + 150)
		
		get_destination(Vector2(x, y))
	elif velocity != Vector2():
		if position.distance_to(destination) <= speed:
			cancel_moving()

func cancel_moving():
	velocity = Vector2()
	destination = Vector2()
	$NotMovTimer.start(2)


func _on_NotMovTimer_timeout():
	staying = true
