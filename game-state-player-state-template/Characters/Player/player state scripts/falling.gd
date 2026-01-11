extends Pstate

@onready var player: Node = $"../.."
@onready var sprite: Node = $"../../AnimatedSprite2D"

var direction

func enter():
	#falling animation
	if sprite.animation != "fall":
		sprite.play("fall")

func exit():
	pass

func handle_input(_event):
	pass
	
func update(_delta):
	pass

func physics_update(delta):
	#move y and apply gravity
	player.velocity.y += Global.GRAVITY * delta
	#get input
	direction = Input.get_axis("move_left", "move_right")
	#aerial movement
	if direction:
		player.velocity.x = direction * Global.PLAYER_SPEED
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, Global.PLAYER_FRICTION)
	#signal state change on ground back to IDLE
	#NOTE: an improvment could be adding a LANDING state that handles smoothly sliding velocity to 0 before IDLE
	if player.is_on_floor():
		EventBus.update_player_state.emit(Global.PlayerState.IDLE)
	player.move_and_slide()
