extends Pstate

@onready var player: Node = $"../.."
@onready var sprite: Node = $"../../AnimatedSprite2D"

#listen for inputs that signal state changes
func handle_input(event):
	#idle animation
	sprite.play("default")
	
	#inputs that will send signal for new state
	if Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
		EventBus.update_player_state.emit(Global.PlayerState.WALKING)
	if Input.is_action_just_pressed("jump"):
		EventBus.update_player_state.emit(Global.PlayerState.JUMPING)

func update(delta):
	pass

#if physics detects we ended up idle but not on the ground, immediately go to falling
#useful for initial spawning if spawn point is not ground level
func physics_update(delta):
	if !player.is_on_floor():
		EventBus.update_player_state.emit(Global.PlayerState.FALLING)
