extends Area2D

signal kill
signal dash

var canBeKilled = false
var mouseOver = false

func _on_SecBot_area_entered(area):
	if not canBeKilled:
		emit_signal("kill")


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_SecBot_mouse_entered():
	mouseOver = true

func _on_SecBot_mouse_exited():
	mouseOver = false

func _physics_process(delta):
	if mouseOver and Input.is_action_pressed("ui_select"):
		canBeKilled = true
