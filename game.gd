extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var selected = null
var isMoving = false
var unit_group = []
var movementNode = null
var selectedTile = null

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process_input(true)
	for child in self.get_children():
		if child is KinematicBody2D:
			unit_group.append(child)
		if child.name == "MovementRange":
			movementNode = child
	for node in unit_group:
		node.connect("moved", self, "_is_moved")
			
func unit_clicked(unit): #called whenever a unit is clicked, handles selection and deselection
	if not isMoving:
		if selected != null and selected.name == unit.name:
			selected = null
		else:
			selected = unit
		movementNode.setSelected(selected)

#currently only does anything when a unit is left clicked or if there is a click in the selected units movement range
func _unhandled_input(event): 
	if  not isMoving and event is InputEventMouseButton and event.is_pressed() and event.button_index == BUTTON_LEFT:
		var mousePos = get_global_mouse_position()
		var x =  int(mousePos[0]/64)
		var y =  int(mousePos[1]/64)
		selectedTile = Vector2(x,y)
		for i in unit_group:
			if i.gridCoords == selectedTile:
				unit_clicked(i)
				return
		if selected and abs(x - selected.gridCoords.x) + abs(y - selected.gridCoords.y) <= selected.moveRange:
			selected.gridCoords = selectedTile
			
func _is_moved(): #toggles movement state in response to a signal from selected
	if isMoving:
		isMoving = false
		selected = null
		movementNode.setSelected(null)
	else:
		isMoving = true
		

