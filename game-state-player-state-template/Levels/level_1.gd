extends Node2D

@onready var player_spawn := $player_spawn
var player_instance: Node

func _ready():
	#spawn player at global position of our spwan marker
	player_instance = load("res://Characters/Player/player.tscn").instantiate()
	player_instance.global_position = player_spawn.global_position
	add_child(player_instance)
