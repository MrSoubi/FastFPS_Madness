extends Area3D

signal on_interaction

var is_player_in_area_of_interaction : bool = false

func _on_body_entered(body: Node3D) -> void:
	if body is Player:
		print("entered")
		is_player_in_area_of_interaction = true

func _on_body_exited(body: Node3D) -> void:
	if body is Player:
		print("exited")
		is_player_in_area_of_interaction = false

func _process(delta: float) -> void:
	if not is_player_in_area_of_interaction:
		return
	
	if Input.is_action_just_pressed("interact"):
		on_interaction.emit()
