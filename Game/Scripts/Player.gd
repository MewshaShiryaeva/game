extends KinematicBody2D

export (int) var speed = 150

onready var target = position
var velocity = Vector2()

func _process(delta):
	if Input.is_action_pressed("right_click"):
		target = get_global_mouse_position()
	
func _physics_process(delta):
	velocity = position.direction_to(target) * speed
	if position.distance_to(target) > 5:
		velocity = move_and_slide(velocity)
	select_animation()

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
