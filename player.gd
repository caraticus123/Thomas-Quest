extends KinematicBody2D

const UP = Vector2(0,-1)
const GRAVITY = 30	
const MAXFALLSPEED = 600	
const MAXSPEED = 240
const JUMPFORCE = 750
const PUNCH_FORCE = 2000
const PUNCH_DAMAGE = 10
const PUNCH_COOLDOWN = 0.5


var motion = Vector2()
var facing_right = true
var punch_timer = 0.0
var punch_direction = Vector2.ZERO

func _ready():
	pass 
	
func _physics_process(delta):
	
	 #punch_timer = max(0, punch_timer - delta)

	
	#if Input.is_action_pressed("punch") and punch_timer <= 0 and Input.is_action_pressed("right"):
	   
		#punch_direction.y -= 1

	  
		#var body = get_node("PunchArea").get_overlapping_bodies()[0]
		#if body and body.has_method("take_damage"):
			#punch_direction = punch_direction.normalized()
			#body.apply_impulse(punch_direction * PUNCH_FORCE)
			#body.take_damage(PUNCH_DAMAGE)

		
		#punch_timer = PUNCH_COOLDOWN
	
	motion.y += GRAVITY
	if motion.y > MAXFALLSPEED:
		motion.y = MAXFALLSPEED
		
	if facing_right == true:
		$Sprite.scale.x = 1
	else:
		$Sprite.scale.x = -1
		
		motion.x = 0
		
	if Input.is_action_pressed("right"):
		motion.x = MAXSPEED
		facing_right = true
		$AnimationPlayer.play("Run")
	elif Input.is_action_pressed("left"):
		motion.x = -MAXSPEED
		facing_right = false
		$AnimationPlayer.play("Run")
	else:
		motion.x = lerp(motion.x,0,0.2)
		$AnimationPlayer.play("Idle")
		
	if is_on_floor():
		
		if Input.is_action_just_pressed("jump"):
			motion.y = -JUMPFORCE
			
	if !is_on_floor():
		if motion.y <0:
			$AnimationPlayer.play("jump")
		elif motion.y > 0:
			$AnimationPlayer.play("fall")
			
	 punch_timer = max(0, punch_timer - delta)

	

	

	motion = move_and_slide(motion,UP)
