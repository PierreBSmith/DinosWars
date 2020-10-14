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
var velocity = Vector2()
var gridCoords = Vector2()

func _ready():
	gridCoords = self.position/64
	
func _physics_process(_delta):
	if selected:
		if not isMoving and (gridCoords*64 - position).length() > 2:
			emit_signal('moved')
			isMoving = true
		if isMoving and (gridCoords*64 - position).length() < 2:
			emit_signal('moved')
			emit_signal('unit_selected', self)
			isMoving = false 
		#rotation = velocity.angle()
		velocity = (gridCoords*64 - position).normalized() * speed
		if (gridCoords*64 - position).length() > 2:
			velocity = move_and_slide(velocity)
		else:
			 self.position = gridCoords*64
		
func _on_KinematicBody2D_input_event(_viewport, event, _shape_idx):
	if  event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		emit_signal('unit_selected', self)
			
func unselect():
	print("Deselected ", self.name)
	selected = false

func isSelected():
	print("Selected ", self.name)
	selected = true
	
func _input(event):
	if  not isMoving and selected and event is InputEventMouseButton and event.is_pressed() and event.button_index == BUTTON_LEFT:
		var mousePos = get_global_mouse_position()
		var x =  floor(mousePos[0]/64)
		var y =  floor(mousePos[1]/64)
		if abs(x - gridCoords.x) + abs(y - gridCoords.y) <= self.moveRange:
			gridCoords = Vector2(x,y)








