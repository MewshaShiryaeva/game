extends KinematicBody2D

var speed = 200
var health = 20

onready var target = position
var velocity = Vector2()
var isWalk: bool



func _ready():
	$AnimatedSprite.play("up")
	$AnimatedSprite.set_frame(1)
	
	global.max_player_health = health
	global.player_health = health
	
func _process(delta):
	global.player_pos = position
	
	isWalk = false
	if Input.is_action_pressed("right_click"):
		target = get_global_mouse_position()
		isWalk = true


func _physics_process(delta):
	if isWalk:
		velocity = position.direction_to(target) * speed
		if position.distance_to(target) > 3:
			velocity = move_and_slide(velocity)
			
			select_animation()
	else:
		$AnimatedSprite.stop()
		$AnimatedSprite.set_frame(1)
		
	
func select_animation():
	if abs(velocity.x) > abs(velocity.y):
		if velocity.x < 0:
			$AnimatedSprite.play("left")
		else:
			$AnimatedSprite.flip_h = true
	elif abs(velocity.x) < abs(velocity.y):
		if velocity.y < 0:
			$AnimatedSprite.play("up")
		else:
			$AnimatedSprite.play("down")
