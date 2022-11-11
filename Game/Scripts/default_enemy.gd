extends KinematicBody2D

var is_angry: bool 
var player_is_attacked : bool
var staying: bool
var speed: int
var speed_atack: int
var range_atack: int
var damage:int
var detection_area: int
var velocity = Vector2()
var destination = Vector2()
var prev_pos = Vector2()
var player_pos = Vector2()
export var x_zone: int
export var y_zone: int


func _ready():
	$AnimatedSprite.speed_scale = speed_atack
	
func _process(delta):
	if velocity:
		prev_pos = position
		select_walk_animation()
		move_and_slide(velocity)
	generate_destination()
	if global.player_health != 0:
		search_player()
	else:
		player_is_attacked = false

func generate_destination():	
	if staying:
		randomize()
		var x = rand_range(x_zone - 90, x_zone + 90)
		var y = rand_range(y_zone - 90, y_zone + 90)
		get_destination(Vector2(x, y))
		
	elif velocity != Vector2():
		if not player_is_attacked:
			if position.distance_to(destination) <= speed:
				cancel_moving()
				$NotMovTimer.start(1.5)
			elif prev_pos.distance_to(position) <= 0.6:
				cancel_moving()
				$NotMovTimer.start(0.5)


func get_destination(dest):
	destination = dest
	velocity = (destination - position).normalized() * speed
	staying = false


func search_player():
	var pl_pos = Vector2(global.player_pos.x, global.player_pos.y)
	if pl_pos.distance_to(position) <= detection_area:
		get_destination(pl_pos)
	if pl_pos.distance_to(position) <= range_atack:
		velocity = Vector2()
		destination = Vector2()
		select_attack_animation()
		player_is_attacked = true
	else:
		player_is_attacked = false


	
func cancel_moving():
	$AnimatedSprite.stop()
	$AnimatedSprite.set_frame(0)
	velocity = Vector2()
	destination = Vector2()

func select_walk_animation():
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

func select_attack_animation():
	if "atack" in $AnimatedSprite.animation:
		return 
	else:
		$AnimatedSprite.play("atack_" + $AnimatedSprite.animation)
		
func _on_NotMovTimer_timeout():
	staying = true


func _on_AnimatedSprite_animation_finished():
	if player_is_attacked and global.player_health >= 0:
		global.player_health -= damage
	
