extends Node

class_name BaseTile
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var occupied = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func toggle_occupied():
	if occupied:
		occupied = false
	else:
		occupied = true
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
