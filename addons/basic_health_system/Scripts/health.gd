@tool

@icon("heart_icon.svg")
class_name EditorHealthComponent
extends Node

@export var MAX_HEALTH: float = 100
var health: float

signal on_death
signal on_take_damage(damage: float)

func _enter_tree() -> void:
	health = MAX_HEALTH

func take_damage(damage: int):
	health = clamp(health - damage, 0, MAX_HEALTH)
	
	on_take_damage.emit(damage)
	
	if (health == 0):
		on_death.emit()
