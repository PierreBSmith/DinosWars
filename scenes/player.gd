extends KinematicBody2D

class_name Player
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var speed = 200
export var moveRange = 0
var selected = false
signal unit_selected
signal moved
var isMoving = false
var gridCoords = Vector2()

func _ready():
	gridCoords = Vector2(int((self.position[0] + 5)/64),int((self.position[1] + 5)/64)) #the +5 is to account for small amounts of error
	
func _physics_process(_delta): #physics logic
	#rotation = velocity.angle() dont uncomment this unless you know what you are doing
	#print("hey ", OS.get_time().second)
	if gridCoords[1]*64 != self.position[1]: #move vertically
		if abs(gridCoords[1]*64 - self.position[1]) > 2:
			move_and_slide(Vector2(0,gridCoords[1]*64 - self.position[1]).normalized() * speed)
		else:
			self.position[1] = gridCoords[1]*64
	elif gridCoords[0]*64 != self.position[0]: #move horizontally
		if abs(gridCoords[0]*64 - self.position[0]) > 2:
			move_and_slide(Vector2(gridCoords[0]*64 -  self.position[0],0).normalized() * speed)
		else:
			self.position[0] = gridCoords[0]*64
	if not isMoving and (gridCoords*64 - position).length() != 0: #set the unit to be moving
		emit_signal('moved')
		isMoving = true
	elif isMoving and (gridCoords*64 - position).length() == 0: #set the unit to be stopped
		emit_signal('moved')
		isMoving = false
