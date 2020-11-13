extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var board_tiles = []
# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(0, len(get_children()[0].get_children())):
		board_tiles.append([])
	for row in get_children():
		var tiles = row.get_children()
		tiles.sort_custom(self, "sort_children")
		for i in range(len(tiles)):
			board_tiles[i].append(tiles[i])

func sort_children(a, b):
	return a.grid_coords.x < b.grid_coords.x

func path_find_enemy(unit, path = [], fringe = [], visited = []):
	#print(path)
	if !path:
		path.append(unit.occupied_tile)
		var successors = find_successors(fringe, path, visited)
		fringe = successors[0]
		visited = successors[1]
	elif path.back().occupied == null or path.back().occupied.friendly != Unit_type.FRIENDLY: 
		var successors = find_successors(fringe, path, visited)
		fringe = successors[0]
		visited = successors[1]
	elif path.back().occupied.friendly == Unit_type.FRIENDLY or path.back().occupied.friendly == Unit_type.NPC:
		if len(path) <= 2 or path[-2].occupied == null:
			return path.slice(1,-2)
	#if there is no path that brings it adjacent to an enemy unit it will not move
	if !fringe:
		return []
	path = fringe.pop_front()
	return path_find_enemy(unit, path, fringe, visited)
	
func find_successors(fringe, path, visited):
	#print(path.back().occupied == null)
	var offsets = [[0,-1],[1,0],[0,1],[-1,0]]
	var neighbors = []
	var curr_path_end = path.back().grid_coords
	for offset in offsets:
		var x = curr_path_end.x + offset[0]
		var y = curr_path_end.y + offset[1]
		if x >= 0 and x < len(board_tiles) and y < len(board_tiles[0]) and y >= 0:
			neighbors.append(board_tiles[x][y])
	for tile in neighbors:
		#print(tile)
		if !(tile in visited):
			fringe.append(path + [tile])
			visited.append(tile)
	#print(fringe)
	return [fringe, visited]

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
