@tool
extends Node3D

@export var mesh_instance_3d: MeshInstance3D

const GRID_MATERIAL_DARK = preload("res://Assets/Materials/Dark/grid_material_dark.tres")
const GRID_MATERIAL_GREEN = preload("res://Assets/Materials/Green/grid_material_green.tres")
const GRID_MATERIAL_LIGHT = preload("res://Assets/Materials/Light/grid_material_light.tres")
const GRID_MATERIAL_ORANGE = preload("res://Assets/Materials/Orange/grid_material_orange.tres")
const GRID_MATERIAL_PURPLE = preload("res://Assets/Materials/Purple/grid_material_purple.tres")
const GRID_MATERIAL_RED = preload("res://Assets/Materials/Red/grid_material_red.tres")

enum grid_color {
	GREEN,
	RED,
	ORANGE,
	PURPLE,
	LIGHT,
	DARK
}

@export var mesh : Mesh :
	get:
		return mesh
	set (value):
		mesh = value
		if Engine.is_editor_hint():
			mesh_instance_3d.mesh = mesh
			_set_grid_color(color)

@export var color : grid_color :
	get:
		return color
	set (value):
		color = value
		if Engine.is_editor_hint():
			_set_grid_color(value)

func _ready() -> void:
	if not Engine.is_editor_hint():
		_set_grid_color(color)

func _set_grid_color(color : grid_color):
	print(color)
	match color:
		grid_color.GREEN:
			mesh_instance_3d.set_surface_override_material(0, GRID_MATERIAL_GREEN)
		grid_color.RED:
			mesh_instance_3d.set_surface_override_material(0, GRID_MATERIAL_RED)
		grid_color.ORANGE:
			mesh_instance_3d.set_surface_override_material(0, GRID_MATERIAL_ORANGE)
		grid_color.PURPLE:
			mesh_instance_3d.set_surface_override_material(0, GRID_MATERIAL_PURPLE)
		grid_color.LIGHT:
			mesh_instance_3d.set_surface_override_material(0, GRID_MATERIAL_LIGHT)
		grid_color.DARK:
			mesh_instance_3d.set_surface_override_material(0, GRID_MATERIAL_DARK)
