extends Node

@onready var game_state_machine = $GameStateMachine
@onready var scene_manager = $SceneManager

func _ready():
	#initialize scene manager and start main menu
	scene_manager.loadMainMenu()
