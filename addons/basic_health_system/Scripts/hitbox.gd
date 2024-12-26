@tool

@icon("res://addons/basic_health_system/Icons/hitbox_icon.svg")
class_name EditorHitboxComponent
extends Area3D

@export var damage: float

signal on_hit_damageable
signal on_hit_staticbody

func _enter_tree() -> void:
	connect("area_entered", _on_area_entered)

func _on_area_entered(area: Area3D) -> void:
	if area is EditorHurtboxComponent:
		on_hit_damageable.emit()
