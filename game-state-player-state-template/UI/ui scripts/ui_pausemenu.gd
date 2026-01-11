extends Control

#pause ui should always be loaded in memory
#we will simply hide it by default
func _ready():
	hide()

#pause_key action should never be handled anywhere else
#handle unhandled pause input by toggling pause on and off
#NOTE: that this logic explicitly checks game states PAUSED and PLAYING
#		this prevents pause from doing anything in other states like GAME OVER, MAIN MENU, etc.
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		if get_tree().paused == false: #we only pause the game if its not already paused
			if Global.Current_GameState == Global.GameState.PLAYING: #pause logic should only happen if game was currently PLAYING
				EventBus.update_game_state.emit(Global.GameState.PAUSED) #update the game state to PAUSED
				show() #show pause ui
				_pause()
		elif get_tree().paused == true: #if the game is already paused
			if Global.Current_GameState == Global.GameState.PAUSED: #verify the game state was set to PAUSED
				_resume() #resume game
				hide() #hide pause ui
				EventBus.update_game_state.emit(Global.GameState.PLAYING)#update the game state to PLAYING

#pauses the game tree
#NOTE: !!! IMPORTANT !!!
#		in the "Inspector" for your pause UI, make sure Process -> Mode is set to Always
#		this means this Node will always process even if the scene tree is paused
#		if you do not do this then .paused() will pause everything INCLUDING the pause ui
func _pause():
	get_tree().paused = true

#unpause the tree
func _resume():
	get_tree().paused = false

#this can be simple since the resume button is only accessible from the UI itself
#this means all we should have to do is resume the game, hide pause UI, and ensure game state is set to PLAYING
func _on_button_resume_pressed() -> void:
	_resume()
	hide()
	EventBus.update_game_state.emit(Global.GameState.PLAYING)

#send a signal to load main menu if "Main Menu" button is clicked on UI
#scene manager will detect this signal and handle game state
func _on_button_backtomenu_pressed() -> void:
	_resume()
	hide()
	EventBus.load_main_menu.emit()

#quit game if quit button is clicked
func _on_button_quitgame_pressed() -> void:
	get_tree().quit()
