extends Pstate

@onready var player: Node = $"../.."
@onready var sprite: Node = $"../../AnimatedSprite2D"

var direction

#if the jump input is detected in this state, signal a change to jumping state
func handle_input(event):
	if Input.is_action_just_pressed("jump"):
		EventBus.update_player_state.emit(Global.PlayerState.JUMPING)
	
func update(delta):
	pass

func physics_update(delta):
	#walk animation
	sprite.play("walk")
	#get direction based on left or right being pressed
	direction = Input.get_axis("move_left", "move_right")
	#ground movement
	if direction:
		player.velocity.x = direction * Global.PLAYER_SPEED
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, Global.PLAYER_FRICTION)
	#signals for state changes
	if player.is_on_floor() == true && player.velocity.x == 0:
		EventBus.update_player_state.emit(Global.PlayerState.IDLE)
	if player.is_on_floor() == false:
		EventBus.update_player_state.emit(Global.PlayerState.FALLING)
	player.move_and_slide()
