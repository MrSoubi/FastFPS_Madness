class_name HitboxComponent
extends Area3D

@export var damage: float

signal on_hit_damageable
signal on_hit_staticbody

func _on_area_entered(area: Area3D) -> void:
	print(area)
	if area is HurtboxComponent:
		on_hit_damageable.emit()

func _on_body_entered(body: Node3D) -> void:
	print(body)
	if body is StaticBody3D:
		on_hit_staticbody.emit()
