extends Node

const health = '0'
const currency = '1'

var world

func save():
	var save_dict = {
		"currency" : world.player.currency,
		"currentBuff" : 'none',
		"buffs" : []
	}
	return save_dict

func save_game():
	var save_game = File.new()
	save_game.open('user://savegame.save', File.WRITE)
	save_game.store_line(to_json(save()))
	save_game.close()	
	
func load_game():
	var playerInfo = {}
	var save_game = File.new()
	if not save_game.file_exists("user://savegame.save"):
		return
	save_game.open("user://savegame.save", File.READ)
	playerInfo = parse_json(save_game.get_line())
	print(playerInfo)
	world.player.currency = playerInfo['currency']
	save_game.close()
