extends Area2D

signal kill

var direction = Vector2.DOWN

func _on_Bullet_area_entered(area):
	emit_signal("kill")

func _physics_process(delta):
	position += direction * 5
