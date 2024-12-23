extends Node3D

@export var template: PackedScene
@export var health: HealthComponent

func _ready() -> void:
	health.on_take_damage.connect(_generate_hitmarker)

func _generate_hitmarker(damage: float):
	var hitmarker = template.instantiate() as HitMarker
	get_tree().root.add_child(hitmarker)
	hitmarker.position = global_position
	hitmarker.rotation = global_rotation
	hitmarker.initialize(damage)
	
