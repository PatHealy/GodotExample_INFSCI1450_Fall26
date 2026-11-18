extends Node

@export var player:PackedScene

var playerList = []

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("start"):
		if event.device not in playerList:
			print("Player device added: " + str(event.device))
			playerList.append(event.device)
			var new_player = player.instantiate()
			new_player.set_player_id(event.device)
			get_parent().add_child(new_player)
