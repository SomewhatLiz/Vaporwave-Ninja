extends Node2D

var repeats = 0
var spawns = []

signal spawn

func _ready():
	for child in get_children():
		if child is Position2D:
			spawns.append(child)

func _on_Timer_timeout():
	emit_signal("spawn", spawns)
	repeats += 1
	if (repeats % 50) == 0:
		$Timer.wait_time = $Timer.wait_time/2
