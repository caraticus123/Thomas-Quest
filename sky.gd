extends Node2D

export var next_scene: PackedScene

func _on_CollisionShape2D_body_entered(body: PhysicsBody2D) -> void:
	# Check if the body that entered the collision shape is a KinematicBody2D or a RigidBody2D
	if body is KinematicBody2D or body is RigidBody2D:
		# Load and change to the next scene
		get_tree().change_scene_to(next_scene)
