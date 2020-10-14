extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var selected = null
var child_group = []
# Called when the node enters the scene tree for the first time.
func _ready():
	set_process_input(true)
	for child in self.get_children():
		if child is KinematicBody2D:
			child_group.append(child)
	for node in child_group:
		node.connect("unit_selected", self, "_on_KinematicBody2D_unit_selected")

			
func _on_KinematicBody2D_unit_selected(unit):
	if selected != null and selected.name == unit.name:
		selected = null
		unit.unselect()
	else:
		if selected != null:
			selected.unselect()
		print("Selected ", unit.name)
		selected = unit
		

