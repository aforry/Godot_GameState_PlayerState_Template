extends CanvasLayer

func _ready():
	self.hide()
	

func _unhandled_input(event: InputEvent):
	if event.is_action_pressed("pause"):
		self.hide()
		$"..".show()
