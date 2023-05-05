extends KinematicBody2D

const SPEED = 100
const JUMP_HEIGHT = 150
const GRAVITY = 500
const ATTACK_RANGE = 50
const KNOCKBACK_FORCE = Vector2(0, -500)
const ATTACK_COOLDOWN = 1
const MAX_HEALTH = 100

var target: Node2D = null
var attack_timer = 0.0
var velocity = Vector2.ZERO
var health = MAX_HEALTH

func _physics_process(delta):
	# Apply gravity
	velocity.y += GRAVITY * delta

	if target:
		# Calculate direction and distance to the target
		var direction = target.global_position - global_position
		var distance = direction.length()

		# Move towards the target if not in attack range
		if distance > ATTACK_RANGE:
			velocity.x = direction.normalized().x * SPEED
			move_and_slide(velocity, Vector2.UP)

		# Attack if in range and cooldown is over
		if distance <= ATTACK_RANGE and attack_timer <= 0:
			knockback(KNOCKBACK_FORCE)
			target.take_damage(10)
			attack_timer = ATTACK_COOLDOWN

		# Jump if the target is above the enemy
		if target.global_position.y < global_position.y and is_on_floor():
			velocity.y = -sqrt(2 * GRAVITY * JUMP_HEIGHT)

	# Update attack cooldown timer
	attack_timer = max(0, attack_timer - delta)

	# Check if the enemy is dead
	if health <= 0:
		queue_free()

func take_damage(damage):
	# Subtract health when the enemy takes damage
	health = max(0, health - damage)

func _on_Area2D_area_entered(area: Area2D) -> void:
	# Check if the entering area is the player
	if area.name == "Player":
		target = area

func _on_Area2D_area_exited(area: Area2D) -> void:
	# Reset target when the player exits the area
	if area.name == "Player":
		target = null

func knockback(force):
	

# This function is called every frame to track the player
func track_player(player: Node2d) -> void:
	if player:
		target = player
