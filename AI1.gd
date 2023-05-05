extends KinematicBody2D

export var speed = 100
export var jump_force = 700
export var gravity = 1000
export var max_fall_speed = 500

var target_player
var velocity = Vector2.ZERO

func _ready():
	target_player = get_node("/root/player")

func _physics_process(delta):
	if target_player:
		var direction = target_player.global_position - global_position
		direction = direction.normalized()
		velocity.x = direction.x * speed
		
		if is_on_floor():
			velocity.y = 0
			if direction.length() < 50:
				velocity.y = -jump_force
		else:
			velocity.y += gravity * delta
			velocity.y = clamp(velocity.y, -max_fall_speed, max_fall_speed)
		
		move_and_slide(velocity, Vector2.UP)
		
		if direction.x > 0:
			$Sprite.flip_h = true
		else:
			$Sprite.flip_h = false
