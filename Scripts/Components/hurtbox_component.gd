class_name HurtboxComponent
extends Area3D

@export var health : HealthComponent
@export var damage_factor : float

func _on_area_entered(area: Area3D) -> void:
	if area is HitboxComponent:
		health.take_damage(area.damage * damage_factor)
