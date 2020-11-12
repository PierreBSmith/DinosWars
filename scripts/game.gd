extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var selected = null
var isMoving = false
var all_group = []
var friendly_group = []
var enemy_group = []
var npc_group = []
var active_group = []
var active_team = Unit_type.FRIENDLY
var movementRange = null
var selectedTile = null
var board = null
var boardTiles = []
# Called when the node enters the scene tree for the first time.
func _ready():
	set_process_input(true)
	for child in self.get_children():
		if child.name == "Board":
			board = child
			for row in board.get_children():
				var boardRow = []
				for tile in row.get_children():
					boardRow.append(tile)
				boardTiles.append(boardRow)
		elif child is KinematicBody2D:
			occupy_tile(child)
			all_group.append(child)
			if child.friendly == Unit_type.FRIENDLY:
				friendly_group.append(child)
				active_group.append(child)
			elif child.friendly == Unit_type.ENEMY:
				enemy_group.append(child)
			elif child.friendly == Unit_type.NPC:
				npc_group.append(child)  
		elif child.name == "MovementRange":
			movementRange = child
	for node in all_group:
		node.connect("moved", self, "_is_moved")
		
			
func unit_clicked(unit): #called whenever a unit is clicked, handles selection and deselection
	if not isMoving:
		if selected != null and selected.name == unit.name:
			selected = null
		elif Unit_type.FRIENDLY == active_team and unit in active_group or unit.friendly != Unit_type.FRIENDLY:
			selected = unit
		movementRange.setSelected(selected)

#currently only does anything when a unit is left clicked or if there is a click in the selected units movement range
func _unhandled_input(event): 
	if  not isMoving and event is InputEventMouseButton and event.is_pressed() and event.button_index == BUTTON_LEFT:
		var mousePos = get_global_mouse_position() #get click location
		var x =  int(mousePos[0]/64)
		var y =  int(mousePos[1]/64)
		selectedTile = Vector2(x,y)
		for i in enemy_group: #if you clicked a unit toggle whether it is selected
			if i.grid_coords == selectedTile:
				unit_clicked(i)
				return
		for i in friendly_group: #if you clicked a unit toggle whether it is selected
			if i.grid_coords == selectedTile:
				unit_clicked(i)
				return
		#if there is a unit at clicked location toggle selection of that unit
		if active_team == Unit_type.FRIENDLY and selected and selected.friendly == Unit_type.FRIENDLY and abs(x - selected.grid_coords.x) + abs(y - selected.grid_coords.y) <= selected.moveRange: 
			selected.grid_coords = selectedTile

func next_turn():
	if active_team == Unit_type.FRIENDLY:
		active_team = Unit_type.ENEMY
		for unit in enemy_group:
			active_group.append(unit)
		enemy_turn()
		next_turn()
	elif active_team == Unit_type.ENEMY:
		#currently no non enemy NPC implemented
		if npc_group:
			active_team = Unit_type.NPC
			for unit in npc_group: 
				active_group.append(unit)
		else:
			active_team = Unit_type.FRIENDLY
			for unit in friendly_group:
				active_group.append(unit)
	else:
		active_team = Unit_type.FRIENDLY
		for unit in friendly_group:
			active_group.append(unit)
	
func enemy_turn():
	for unit in active_group:
		selected = unit
		if !boardTiles[selected.grid_coords.x][selected.grid_coords.y - 1].occupied:
			selected.grid_coords = Vector2(unit.grid_coords.x, unit.grid_coords.y - 1)

func occupy_tile(unit):
	boardTiles[unit.grid_coords.x][unit.grid_coords.y].toggle_occupied()
	unit.occupied_tile = boardTiles[unit.grid_coords.x][unit.grid_coords.y]

func unoccupy_tile(unit):
	unit.occupied_tile.toggle_occupied()
	unit.occupied_tile = null
	
#toggles movement state in response to a signal from selected, deselects unit when it stops moving
func _is_moved():
	if isMoving:
		print(selected.name, " stopped moving")
		isMoving = false
		active_group.erase(selected)
		occupy_tile(selected)
		selected = null
		movementRange.setSelected(null)
		if active_team == Unit_type.FRIENDLY and !active_group:
			next_turn()
	else:
		print(selected.name, " is moving")
		unoccupy_tile(selected)
		isMoving = true
