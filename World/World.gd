extends Node2D

var rng = RandomNumberGenerator.new()

var SecBotRes = load('res://Enemies/SecBot/SecBot.tscn')
var ShootBotRes = load('res://Enemies/ShootBot/ShootBot.tscn')
var AttackBotRes = load('res://Enemies/AttackBot/AttackBot.tscn')
var bots = [SecBotRes, ShootBotRes, AttackBotRes]

var playerDead = false

onready var player = $Player
onready var gui = $gui
onready var cam = $Camera2D

func _ready():
	player.connect('updateInfo', self, 'changeGUI')
	$Camera2D/spawns.connect('spawn', self, 'spawnBot')
	cam.position = player.position
	Global.world = get_node(get_path())
	print(Global.world)
	Global.load_game()

func pickBot():
	rng.randomize()
	var roll = rng.randi_range(0, 100)
	if roll < 30:
		return 0
	elif roll < 75:
		return 1
	else:
		return 2
	
	
	
func spawnBot(spawnLocations):
	rng.randomize()
	var spawn = spawnLocations[rng.randi_range(0, spawnLocations.size() - 1)].global_position
	rng.randomize()
	var bot = bots[pickBot()].instance()
	add_child(bot)
	bot.position = spawn
	bot.connect('kill', self, 'killPlayer')
	
func changeGUI(info):
	var playerHealth = info[Global.health]
	var playerCurrency = info[Global.currency]
	if playerHealth > 0:
		gui.health.value = playerHealth
	gui.currency.text = str(playerCurrency)
	
func camChange():
	#cam.position.y = player.position.y - 280.6
	cam.position.y -= 5

func killPlayer():
	gui.get_node("died").visible = true
	playerDead = true
	player.alive = false
	get_tree().change_scene('res://Menus/Opening.tscn')
	Global.save_game()
	
func _physics_process(delta):
	if not playerDead:
		camChange()
