extends Node
class_name Pstate

#this defines a CLASS for player state called Pstate
#now we can extend this class name to individual state nodes and extend the functions below
#we want functions that we will pass delta or events from _process, _physics_process, and _input in the CharacterBody2D node / Player

func update(delta):
	pass

func physics_update(delta):
	pass

func handle_input(event):
	pass
