extends Pstate

@onready var player: Node = $"../.."
@onready var sprite: Node = $"../../AnimatedSprite2D"

var direction

func enter():
	#walk animation
	if sprite.animation != "walk":
		sprite.play("walk")

func exit():
	pass

func handle_input(_event):
	pass
	
func update(_delta):
	pass

func physics_update(_delta):
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
	if Input.is_action_just_pressed("jump"):
		EventBus.update_player_state.emit(Global.PlayerState.JUMPING)
	player.move_and_slide()
