extends KinematicBody2D

export (int) var speed = 150

onready var target = position
var velocity = Vector2()
var isWalk: bool


func return_position():
	return position


func _process(delta):
	isWalk = false
	if Input.is_action_pressed("right_click"):
		target = get_global_mouse_position()
		isWalk = true

func _physics_process(delta):
	if isWalk:
		velocity = position.direction_to(target) * speed
		if position.distance_to(target) > 5:
			velocity = move_and_slide(velocity)
		select_animation()
	else:
		if $AnimatedSprite.animation == "walkDown":
			$AnimatedSprite.play("down")
		elif $AnimatedSprite.animation == "walkUp":
			$AnimatedSprite.play("up")
		elif $AnimatedSprite.animation == "walkLeft":
			$AnimatedSprite.play("left")
		elif $AnimatedSprite.animation == "walkRight":
			$AnimatedSprite.play("right")
			 
func select_animation():
	if abs(velocity.x) > abs(velocity.y):
		if velocity.x < 0:
			
			#$AnimatedSprite.play("left")
			$AnimatedSprite.play("walkLeft")
		else:
			#$AnimatedSprite.play("right")
			$AnimatedSprite.play("walkRight")
	elif abs(velocity.x) < abs(velocity.y):
		if velocity.y < 0:
			#$AnimatedSprite.play("up")
			$AnimatedSprite.play("walkUp")
		else:
			#$AnimatedSprite.play("down")
			$AnimatedSprite.play("walkDown")
			
