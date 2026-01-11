extends Node

func _ready() -> void:
	#start listener for game state updates
	EventBus.update_game_state.connect(updateGameState)

#when game state machine gets a signal for a new game state - set new state and refresh HUD
func updateGameState(newState: Global.GameState):
	Global.Current_GameState = newState
	EventBus.update_hud.emit()
