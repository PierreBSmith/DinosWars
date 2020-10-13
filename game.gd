extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var selected = null
# Called when the node enters the scene tree for the first time.
func _ready():
	set_process_input(true)
	
func _input(event):
	if event and event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		if selected:
			print('position set', event.position)
			selected.unselect()
			selected = null
			
func _on_KinematicBody2D_unit_selected(unit):
	print('hi')
	if selected != null:
		selected.unselect()
	selected = unit
	

func _on_KinematicBody2D2_unit_selected(unit):
	print('hi hi')
	if selected != null:
		selected.unselect()
	selected = unit
	 # Replace with function body.
