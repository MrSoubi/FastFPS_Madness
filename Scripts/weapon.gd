extends Node3D

@export var projectile_template : PackedScene
@onready var projectile_origin: Node3D = $ProjectileOrigin

func shoot(player_velocity : Vector3):
	var new_projectile = projectile_template.instantiate()
	get_tree().root.add_child(new_projectile)
	new_projectile.position = projectile_origin.global_position
	new_projectile.rotation = global_rotation
	
	if new_projectile is Projectile:
		new_projectile.initial_speed = player_velocity
