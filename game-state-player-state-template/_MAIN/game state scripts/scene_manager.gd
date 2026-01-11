extends Node

#instance the mainmenu node and debug ui
@onready var mainmenu_instance := $"../Ui-mainmenu"
@onready var hud_ui := $"../Ui-hud"
#these vars will be used when a signal is heard to change levels
var scene_instance: Node
var levelpath: String

# start any UI or scene event listeners needed
func _ready() -> void:
	EventBus.load_main_menu.connect(loadMainMenu)
	EventBus.load_level.connect(loadLevel)
	EventBus.update_hud.connect(updateHUD)

#display the mainmenu node
#update game state to MAINMENU
#free scene tree of any previously loaded levels
func loadMainMenu():
	levelQueueFree()
	mainmenu_instance.show()
	EventBus.update_game_state.emit(Global.GameState.MAINMENU)

#hide the mainmenu instance, .hide() does nothing if already hidden
#free scene tree of previous loaded level
#instance a new scene using concatenated level path
#updates GameState to PLAYING
#
#	in this project: level scenes are level1, level2, level3, etc.
#	the signal change_levels only needs to pass a number for which level we want to load
#
#	alternatively - you could keep an enum or dictionary of level names but could be harder to manage as you add more level names
#		example: name level scenes like...
#				GRASS_LEVEL.tscn, FIRE_LEVEL.tscn
#				have a global enum like...
#				enum LevelName{GRASS_LEVEL, FIRE_LEVEL, ICE_LEVEL}
#				have a global signal like...
#				signal load_level(level_name: String)
#				then to emit...
#				EventBus.load_level.emit(Global.LevelName.findKey(Global.LevelName.GRASS_LEVEL)) #findKey() returns string of enum
#
func loadLevel(level_num: int):
	mainmenu_instance.hide()
	levelQueueFree()
	levelpath = "res://Levels/Level"+str(level_num)+".tscn"
	scene_instance = load(levelpath).instantiate()
	add_child(scene_instance)
	EventBus.update_game_state.emit(Global.GameState.PLAYING)

#this function frees the current instanced node from the scene tree
#	NOTE we only ever .show() or .hide() UI nodes, NOT .queue_free()
#		this is because we always want UI scenes in memory
func levelQueueFree():
	if scene_instance != null:
		scene_instance.queue_free()

func updateHUD():
	hud_ui.update_display()
