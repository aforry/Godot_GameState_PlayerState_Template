extends Pstate

@onready var player: Node = $"../.."
@onready var sprite: Node = $"../../AnimatedSprite2D"

var direction

func handle_input(event):
	pass
	
func update(delta):
	pass

func physics_update(delta):
	#jump animation
	sprite.play("jump")
	#move y by jump force
	player.velocity.y = Global.PLAYER_JUMP_FORCE
	#allow x-axis adjustment while punching
	direction = Input.get_axis("move_left", "move_right")
	#aerial movement left-right
	if direction:
		player.velocity.x = direction * Global.PLAYER_SPEED
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, Global.PLAYER_FRICTION)
	player.move_and_slide()
	#wait for jump animation to fully complete
	await sprite.animation_finished
	#signals change state to falling
	EventBus.update_player_state.emit(Global.PlayerState.FALLING)
