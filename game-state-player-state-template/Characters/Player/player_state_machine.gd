extends Node

var player_state_text : String
var player_state_node : Node

func _ready() -> void:
	#start listener for player state updates
	EventBus.update_player_state.connect(updatePlayerState)

#set player state to signalled new state
#refresh HUD
func updatePlayerState(newState: Global.PlayerState):
	Global.Current_PlayerState = newState
	EventBus.update_hud.emit()

#these handle functions are the heart of the player state machine
#the state machine determines which current state node to process
#passes the delta/event from the parent player node to the current state node
func handlePlayerStateProcess(delta: float):
	player_state_node = getPlayerStateNode()
	player_state_node.update(delta)

func handlePlayerStatePhysicsProcess(delta: float):
	player_state_node = getPlayerStateNode()
	player_state_node.physics_update(delta)
	
func handlePlayerStateInput(event: InputEvent):
	player_state_node = getPlayerStateNode()
	player_state_node.handle_input(event)

#using the current global playerstate, search the children nodes of our player state machine
#return the node that matches the name of the current player state
#NOTE: this means the nodes for each player state MUST be children of the player_state_machine in the Scene tree
func getPlayerStateNode():
		player_state_text = Global.PlayerState.find_key(Global.Current_PlayerState).to_lower()
		for child in get_children():
			if child.name == player_state_text && child is Pstate: #only return node if it matches the state name and extends the pstate class
				return child
