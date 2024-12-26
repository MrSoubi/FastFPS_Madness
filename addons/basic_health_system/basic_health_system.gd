@tool
extends EditorPlugin


func _enter_tree() -> void:
	add_custom_type("Health", "Node", preload("res://addons/basic_health_system/Scripts/health.gd"), preload("res://addons/basic_health_system/Icons/heart_icon.svg"))
	add_custom_type("Hitbox", "Area3D", preload("res://addons/basic_health_system/Scripts/hitbox.gd"), preload("res://addons/basic_health_system/Icons/hitbox_icon.svg"))
	add_custom_type("Hurtbox", "Area3D", preload("res://addons/basic_health_system/Scripts/hurtbox.gd"), preload("res://addons/basic_health_system/Icons/hurtbox_icon.svg"))

func _exit_tree() -> void:
	remove_custom_type("Health")
	remove_custom_type("Hitbox")
	remove_custom_type("Hurtbox")
