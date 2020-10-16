extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var selected = null
var isMoving = false
var friendly_group = []
var enemy_group = []
var movementNode = null
var selectedTile = null

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process_input(true)
	for child in self.get_children():
		if child is KinematicBody2D:
			if child.friendly:
				friendly_group.append(child)
			elif not child.friendly:
				enemy_group.append(child)
		if child.name == "MovementRange":
			movementNode = child
	for node in friendly_group:
		node.connect("moved", self, "_is_moved")
	for node in enemy_group:
		node.connect("moved", self, "_is_,moved")
			
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
		var mousePos = get_global_mouse_position() #get click location
		var x =  int(mousePos[0]/64)
		var y =  int(mousePos[1]/64)
		selectedTile = Vector2(x,y)
		for i in enemy_group: #if you clicked a unit toggle whether it is selected
			if i.gridCoords == selectedTile:
				unit_clicked(i)
				return
		for i in friendly_group: #if you clicked a unit toggle whether it is selected
			if i.gridCoords == selectedTile:
				unit_clicked(i)
				return
		#if there is a unit at clicked location toggle selection of that unit
		if selected and selected.friendly and abs(x - selected.gridCoords.x) + abs(y - selected.gridCoords.y) <= selected.moveRange: 
			selected.gridCoords = selectedTile

#toggles movement state in response to a signal from selected, deselects unit when it stops moving
func _is_moved():
	if isMoving:
		isMoving = false
		selected = null
		movementNode.setSelected(null)
	else:
		isMoving = true
