extends KinematicBody2D

var staying = true
var speed = 45
var velocity = Vector2()
var destination = Vector2()

func select_animation():
	if abs(velocity.x) > abs(velocity.y):
		if velocity.x < 0:
			$AnimatedSprite.play("left")
		else:
			$AnimatedSprite.play("right")
	elif abs(velocity.x) < abs(velocity.y):
		if velocity.y < 0:
			$AnimatedSprite.play("up")
		else:
			$AnimatedSprite.play("down")


func _process(delta):
	if velocity:
		select_animation()
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
	$AnimatedSprite.stop()
	$AnimatedSprite.set_frame(0)
	velocity = Vector2()
	destination = Vector2()
	$NotMovTimer.start(3)


func _on_NotMovTimer_timeout():
	staying = true
