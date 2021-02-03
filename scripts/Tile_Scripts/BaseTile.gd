extends Node

class_name BaseTile
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
enum Tile_Type{
	GRASS,
	FOREST,
	WATER,
	SAND,
	MOUNTAIN,
	FORTRESS
}
#These are the stuff the change depending on Tile Type. Should be set in.... is there an Awake Function?
var walkable
var tile_type #this will be set in the inheritor class
#Whenever I mention "unit" I mean the unit currently occupying the tile.
var avoid_bonus #Effects unit's evasion rate. Represents a percentage
var def_res_bonus #Effects unit's defense and resistance stats. These are hard numbers
var movement_bonus #you know how when you fight in sand, you can't move as far. That stuff.

#These variables are the dynamically set stuff
var occupied = null

#Not much to explain here.
var grid_coords
# Called when the node enters the scene tree for the first time.
func _ready():
	grid_coords = Vector2(int((get_child(0).position[0] + 5)/64),int((get_parent().position[1] + 5)/64)) #the +5 is to account for small amounts of error

#if called with a unit passed will have unit occupy that tile, otherwise sets occupied to null
func toggle_occupied(unit = null):
	if unit != null:
		occupied = unit
	else:
		occupied = null
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

#Setting TileType Helper Function
func set_tile(var type_of_tile):
	match typeof(type_of_tile):
		Tile_Type.GRASS:
			walkable = true
			avoid_bonus = 0
			def_res_bonus = 0
			movement_bonus = 0
			print(type_of_tile)
		Tile_Type.FOREST:
			walkable = true
			avoid_bonus = 10
			def_res_bonus = 0
			movement_bonus = -1
			print(type_of_tile)
		Tile_Type.MOUNTAIN:
			walkable = false
			avoid_bonus = 30
			def_res_bonus = 5
			movement_bonus = -3
			print(type_of_tile)
		Tile_Type.WATER:
			walkable = false
			avoid_bonus = 0
			def_res_bonus = 0
			movement_bonus = -3
			print(type_of_tile)
		Tile_Type.SAND:
			walkable = true
			avoid_bonus = -10
			def_res_bonus = 0
			movement_bonus = -2
			print(type_of_tile)
		Tile_Type.FORTRESS:
			walkable = true
			avoid_bonus = 0
			def_res_bonus = 10
			movement_bonus = 0
			print(type_of_tile)
