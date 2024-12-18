extends Node3D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _on_player_on_attack() -> void:
	animation_player.play("attack")
