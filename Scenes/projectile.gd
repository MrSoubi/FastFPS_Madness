extends Node3D

@export var speed : float = 20

func initialize(direction : Vector3):
	self.direction = direction

func _process(delta: float) -> void:
	position += speed * -get_global_transform().basis.z * delta

func destroy():
	print("should destroy")
	queue_free()
