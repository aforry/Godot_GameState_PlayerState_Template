extends CharacterBody2D

@onready var sprite := $AnimatedSprite2D
@onready var player_state_machine := $player_state_machine
var state_node : Pstate

var flipped: bool

func _ready():
	#initialize player to idle state
	EventBus.update_player_state.emit(Global.PlayerState.IDLE)
	#character starts facing right / unflipped
	flipped = false

#we pass arguments for CharacterBody2D class functions down to the player state machine
#the player state machine then passes the arguments again to the state node corresponding to the current player state
func _input(event: InputEvent) -> void:
	player_state_machine.handlePlayerStateInput(event)
	
func _process(delta: float) -> void:
	player_state_machine.handlePlayerStateProcess(delta)

func _physics_process(delta: float) -> void:
	orientPlayerXaxis()
	player_state_machine.handlePlayerStatePhysicsProcess(delta)

func orientPlayerXaxis():
	#always keep character oriented properly on x-axis when moving
	#this is on the CharacterBody2D, because we want this flip accurate regardless of player state
	#scaling x to -1 instead of just flipping the sprite is better because it will also flip physics/shapes properly
	if velocity.x > 0 && flipped:
		self.scale.x = -1
		flipped = false
	if velocity.x < 0 && !flipped:
		self.scale.x = -1
		flipped = true
