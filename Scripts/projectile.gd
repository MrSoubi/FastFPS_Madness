class_name Projectile
extends Node3D

@export var speed : float = 40
var initial_speed : Vector3

func _process(delta: float) -> void:
	position += (initial_speed + speed * -get_global_transform().basis.z) * delta

func destroy():
	print("should destroy")
	queue_free()
