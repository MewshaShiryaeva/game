extends KinematicBody2D



var staying = true
var speed = 45
var velocity = Vector2()
var destination = Vector2()
var prev_pos = Vector2()
export var x_clamp = 0
export var y_clamp = 0


func _ready():
	pass
	
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
		prev_pos = position
		select_animation()
		move_and_slide(velocity)
	generate_destination()
	search_player()
	
func get_destination(dest):
	destination = dest
	velocity = (destination - position).normalized() * speed
	staying = false

func generate_destination():	
	if staying:
		randomize()
	
		var x = rand_range(x_clamp - 90, x_clamp + 90)
		var y = rand_range(y_clamp - 90, y_clamp + 90)
		
		get_destination(Vector2(x, y))
	elif velocity != Vector2():
		if position.distance_to(destination) <= speed:
			cancel_moving()
		elif prev_pos.distance_to(position) <= 0.6:
			cancel_moving()


func search_player():
	var pl_pos = Vector2(global.player_pos.x, global.player_pos.y)
	if pl_pos.distance_to(position) <= 200:
		get_destination(pl_pos)

func cancel_moving():
	$AnimatedSprite.stop()
	$AnimatedSprite.set_frame(0)
	velocity = Vector2()
	destination = Vector2()
	$NotMovTimer.start(3)


func _on_NotMovTimer_timeout():
	staying = true
