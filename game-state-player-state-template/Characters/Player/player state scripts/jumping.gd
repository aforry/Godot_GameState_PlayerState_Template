extends Pstate

@onready var player: Node = $"../.."
@onready var sprite: Node = $"../../AnimatedSprite2D"

var direction

func enter():
	#jump animation
	if sprite.animation != "jump":
		sprite.play("jump")
		
func exit():
	pass

func handle_input(_event):
	pass
	
func update(_delta):
	pass

func physics_update(delta):
	#apply the initial jump force while on floor, else apply gravity
	if player.is_on_floor():
		player.velocity.y = Global.PLAYER_JUMP_FORCE
	elif !player.is_on_floor():
		player.velocity.y += Global.GRAVITY * delta
	#if player hits ceiling, kill y velocity and signal for FALLING
	if player.is_on_ceiling():
		player.velocity.y = 0
		EventBus.update_player_state.emit(Global.PlayerState.FALLING)
	#allow x-axis adjustment while punching
	direction = Input.get_axis("move_left", "move_right")
	#aerial movement left-right
	if direction:
		player.velocity.x = direction * Global.PLAYER_SPEED
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, Global.PLAYER_FRICTION)
	player.move_and_slide()
	#when player reaches apex of jump, start falling
	if player.velocity.y >= 0:
		EventBus.update_player_state.emit(Global.PlayerState.FALLING)
