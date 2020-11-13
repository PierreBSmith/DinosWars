extends KinematicBody2D

class_name Unit

export var speed = 500
var moveError = speed/100
export var move_range = 0
var selected = false
signal moved
var isMoving = false
var grid_coords = Vector2()
var friendly = Unit_type.FRIENDLY
var hasAction = true
var attackRange = 1
var occupied_tile = null

func _ready():
	grid_coords = Vector2(int((self.position[0] + 5)/64),int((self.position[1] + 5)/64)) #the +5 is to account for small amounts of error
	
	
func _physics_process(_delta): #physics logic
	#rotation = velocity.angle() dont uncomment this unless you know what you are doing
	#print("hey ", OS.get_time().second)
	if grid_coords[1]*64 != self.position[1]: #move vertically
		if abs(grid_coords[1]*64 - self.position[1]) > moveError:
			move_and_slide(Vector2(0,grid_coords[1]*64 - self.position[1]).normalized() * speed)
		else:
			self.position[1] = grid_coords[1]*64
	elif grid_coords[0]*64 != self.position[0]: #move horizontally
		if abs(grid_coords[0]*64 - self.position[0]) > moveError:
			move_and_slide(Vector2(grid_coords[0]*64 -  self.position[0],0).normalized() * speed)
		else:
			self.position[0] = grid_coords[0]*64
	if not isMoving and (grid_coords*64 - position).length() != 0: #set the unit to be moving
		emit_signal('moved')
		isMoving = true
	elif isMoving and (grid_coords*64 - position).length() == 0: #set the unit to be stopped
		emit_signal('moved')
		isMoving = false
