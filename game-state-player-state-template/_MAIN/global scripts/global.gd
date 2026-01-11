extends Node

#!!! IMPORTANT !!!
#click on "Project" menu
#click on "Project Settings..."
#click on "Globals" tab
#add path to this Global.gd file
#name it something useful like "Global"
#you can now use anything defined here with Global.

#game state enums
#useful to make gamestate known globally for events
enum GameState {
	MAINMENU,
	PLAYING,
	PAUSED,
	GAMEOVER
}
#player state enums
#useful to make playerstate known globally for events
enum PlayerState {
	IDLE,
	WALKING,
	JUMPING,
	FALLING
}

#global constants
const GRAVITY = 400
const PLAYER_SPEED = 200
const PLAYER_FRICTION = 10
const PLAYER_JUMP_FORCE = -200

#global variables
#these will track the current level we are on, and the states we are in
#this will be useful for ensuring certain events can only trigger in certain states
#
#example: if Global.Current_GameState == Global.GameState.PLAYING:
var Current_Level: int
var Current_GameState: GameState
var Current_PlayerState: PlayerState
