extends Area2D

var health = 10
var currency = 0
var repeats = 0
var alive = true
var moveTo = Vector2(0, 0)
var dashing = false

signal updateInfo

func move():
	currency += 1
	if Input.is_action_just_released("ui_select"):
		var rawPos = get_global_mouse_position()
		moveTo = rawPos
		dashing = true
	if dashing:
		position = lerp(position, moveTo, 0.1)
	if position == moveTo:
		dashing = false
		
func _physics_process(delta):
	if alive:
		move()
	emit_signal("updateInfo", {Global.health : health, Global.currency : currency})
	


func _on_player_area_entered(area):
	if dashing:
		area.queue_free()

