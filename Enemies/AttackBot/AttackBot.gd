extends "res://Enemies/SecBot/SecBot.gd"

var bulletRes = load("res://Enemies/Bullet/Bullet.tscn")
var onScreen = false

var dirs = [Vector2.UP, Vector2.DOWN, Vector2.LEFT, Vector2.RIGHT]

onready var timer = $Timer

func shoot():
	for dir in dirs:
		var bullet = bulletRes.instance()
		add_child(bullet)
		bullet.global_position = global_position
		bullet.direction = dir
		bullet.connect("kill", self, "killPlayer")

func killPlayer():
	emit_signal("kill")

func _on_Timer_timeout():
	timer.stop()

func _on_VisibilityNotifier2D_screen_entered():
	onScreen = true

func _physics_process(delta):
	if timer.is_stopped():
		shoot()
		timer.start()
