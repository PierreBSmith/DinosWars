extends Node

class_name BaseTile
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var occupied = null
var grid_coords
# Called when the node enters the scene tree for the first time.
func _ready():
	grid_coords = Vector2(int((get_child(0).position[0] + 5)/64),int((get_parent().position[1] + 5)/64)) #the +5 is to account for small amounts of error

func toggle_occupied(unit = null):
	if occupied == null:
		occupied = unit
	else:
		occupied = null
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
