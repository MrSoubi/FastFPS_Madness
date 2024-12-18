class_name PlayerLife
extends Resource

var life: int :
	get: return life
	set(value):
		life = value
		on_value_changed.emit(life)

signal on_value_changed(value: int)
