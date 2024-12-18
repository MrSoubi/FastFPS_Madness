class_name HealthComponent
extends Node

@export var MAX_HEALTH: float
var health: float

signal on_death
signal on_take_damage(damage: float)

func _ready() -> void:
	health = MAX_HEALTH

func take_damage(damage: int):
	health = clamp(health - damage, 0, MAX_HEALTH)
	
	on_take_damage.emit(damage)
	
	if (health == 0):
		on_death.emit()
