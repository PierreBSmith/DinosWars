extends BaseTile
# Called when the node enters the scene tree for the first time.
func _ready():
	tile_type = Tile_Type.MOUNTAIN
	set_tile(tile_type)
