extends Control

#main menu basic functionality
#new game button pressed just signals to load level1
#quit game button will quit the entire game tree i.e. close game

func _on_button_newgame_pressed() -> void:
	EventBus.load_level.emit(1)

func _on_button_quitgame_pressed() -> void:
	get_tree().quit()

func _on_button_license_pressed() -> void:
	self.hide()
	$"font-license".show()
	$"font-license/font-license-control/font-license-bg/font-license-info".get_v_scroll_bar().value = 0
