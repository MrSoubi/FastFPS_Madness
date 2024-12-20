extends Node3D

@export var projectile_template : PackedScene

func shoot():
	print("shoot")
	var new_projectile = projectile_template.instantiate()
	get_tree().root.add_child(new_projectile)
	new_projectile.position = global_position
	new_projectile.rotation = global_rotation
