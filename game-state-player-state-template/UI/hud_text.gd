extends Control

@onready var hud_text := $RichTextLabel
#for this example project the "HUD" is just a richtextlabel that allows you to visually see game states and player states
#However, this should showcase how you could use signals elsewhere to call an "update_display" function and update a player HUD

func update_display():
	hud_text.text = "Game State: " + str(Global.GameState.find_key(Global.Current_GameState)) + "\nPlayer State: " + str(Global.PlayerState.find_key(Global.Current_PlayerState))
