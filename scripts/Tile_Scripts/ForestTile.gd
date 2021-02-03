extends BaseTile
# Called when the node enters the scene tree for the first time.
func _ready():
	tile_type = Tile_Type.FOREST
	set_tile(tile_type)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
