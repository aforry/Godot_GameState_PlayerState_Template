extends Node

#!!! IMPORTANT !!!
#click on "Project" menu
#click on "Project Settings..."
#click on "Globals" tab
#add path to this Global.gd file
#name it something useful like "EventBus" or "Events" or "SignalBus" etc.
#you can now use any signals here anywhere in the project
#
#for example: player logic could use... EventBus.update_player_state.emit(Global.PlayerState.IDLE)
#
#				a player state machine could listen for this signal to change states...
#				
#				func _ready(): #connects listener before this node is ready
#					EventBus.update_player_state.connect(updatePlayerState) #listen to signals with .connect(funcName) the argument for the func gets passed by the emit elsewhere
#					
#				func updatePlayerState(newState: Global.PlayerState): #updates current playerstate in global when signal received
#					Global.Current_PlayerState = newState #using the example above we would pass the IDLE state

#signals for game-wide events
@warning_ignore_start("UNUSED_SIGNAL") #we ignore unused_signal warnings as these signals are not used natively in this Node so will always show warnings in debug console
#UI signals
signal load_main_menu()
signal toggle_pause()
signal update_hud()
#state machine signals
signal update_game_state(new_state: Global.GameState)
signal update_player_state(new_state: Global.PlayerState)
#scene manager signals
signal load_level(num_level: int)
@warning_ignore_restore("UNUSED_SIGNAL")
