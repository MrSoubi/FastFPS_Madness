@tool

@icon("res://addons/basic_health_system/Icons/hurtbox_icon.svg")
class_name EditorHurtboxComponent
extends Area3D

@export var health : EditorHealthComponent
@export var damage_factor : float = 1

func _get_configuration_warnings():
	if not health:
		return ["Health component must be defined."]
	return []

func _enter_tree() -> void:
	connect("area_entered", _on_area_entered)

func _on_area_entered(area: Area3D) -> void:
	if area is EditorHitboxComponent:
		var damage = area.damage * damage_factor
		health.take_damage(damage)
