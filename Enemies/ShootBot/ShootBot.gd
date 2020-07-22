extends "res://Enemies/SecBot/SecBot.gd"

var bulletRes = load("res://Enemies/Bullet/Bullet.tscn")
var onScreen = false
var playerDetected = false

onready var ray = $RayCast2D
onready var timer = $Timer

func shoot():
	var bullet = bulletRes.instance()
	add_child(bullet)
	bullet.global_position = global_position
	bullet.connect("kill", self, "killPlayer")
	playerDetected = false

func killPlayer():
	emit_signal("kill")
	
func _on_Timer_timeout():
	timer.stop()

func _on_VisibilityNotifier2D_screen_entered():
	onScreen = true

func _physics_process(delta):
	if ray.is_colliding():
		playerDetected = true
	if timer.is_stopped():
		if playerDetected:
			shoot()
			timer.start()
