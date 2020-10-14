extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var selected = null
var isMoving = false
var child_group = []
var MovementNode = null
# Called when the node enters the scene tree for the first time.
func _ready():
	set_process_input(true)
	for child in self.get_children():
		if child is KinematicBody2D:
			child_group.append(child)
		if child.name == "MovementRange":
			MovementNode = child
	for node in child_group:
		node.connect("unit_selected", self, "_on_KinematicBody2D_unit_selected")
		node.connect("moved", self, "_is_moved")

			
func _on_KinematicBody2D_unit_selected(unit):
	if not isMoving:
		if selected != null and selected.name == unit.name:
			selected = null
			unit.unselect()
		else:
			if selected != null:
				selected.unselect()
			unit.isSelected()
			selected = unit
		MovementNode.setSelected(selected)


	
func _is_moved():
	if isMoving:
		isMoving = false
	else:
		isMoving = true
		

