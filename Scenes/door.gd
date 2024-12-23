extends Node3D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _on_interactible_on_interaction() -> void:
	animation_player.play("open")
