extends Pstate

@onready var player: Node = $"../.."
@onready var sprite: Node = $"../../AnimatedSprite2D"


func enter():
	#idle animation
	if sprite.animation != "idle":
		sprite.play("idle")
		
func exit():
	pass

func handle_input(_event):
	pass

func update(_delta):
	pass


func physics_update(_delta):
	#inputs that will send signal for new state
	if Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
		EventBus.update_player_state.emit(Global.PlayerState.WALKING)
	if Input.is_action_just_pressed("jump"):
		EventBus.update_player_state.emit(Global.PlayerState.JUMPING)
	#if physics detects we ended up idle but not on the ground, immediately go to falling
	#useful for initial spawning if spawn point is not ground level
	if !player.is_on_floor():
		EventBus.update_player_state.emit(Global.PlayerState.FALLING)
