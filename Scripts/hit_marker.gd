class_name HitMarker
extends Label3D

func initialize(damage: float):
	text = str(damage)
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", position + Vector3.UP, 1)
	tween.tween_callback(destroy)

func destroy():
	self.queue_free()
