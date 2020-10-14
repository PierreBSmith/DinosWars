extends KinematicBody2D

class_name Player
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var speed = 200
var selected = false
signal unit_selected

var target = Vector2()
var velocity = Vector2()


func _physics_process(_delta):
	if selected:
		velocity = (target - position).normalized() * speed
		#rotation = velocity.angle()
		if (target - position).length() > 5:
			velocity = move_and_slide(velocity)
	else:
		target = self.position
		
func _on_KinematicBody2D_input_event(_viewport, event, _shape_idx):
	if  event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		selected = true
		emit_signal('unit_selected', self)
			
func unselect():
	print("Deselected ", self.name)
	selected = false

func _input(event):
	if  selected and event is InputEventMouseButton and event.is_pressed() and event.button_index == BUTTON_LEFT:
			target = get_global_mouse_position()


#var grid_size = 64
#onready var ray = $RayCast2D
#
#var inputs = {
#	'ui_up' : Vector2.UP,
#	'ui_down' : Vector2.DOWN,
#	'ui_left' : Vector2.LEFT,
#	'ui_right' : Vector2.RIGHT
#}
#
#func _unhandled_input(event):
#	for dir in inputs.keys():
#		if event.is_action_pressed(dir):
#			move(dir)
#
#func move(dir):
#	var vector_pos = inputs[dir] * grid_size
#	ray.cast_to = vector_pos
#	ray.force_raycast_update()
#	if !ray.is_colliding():
#		position += vector_pos
#
#
#
#func _on_KinematicBody2D_input_event(viewport, event, shape_idx):
#	if event is InputEventMouseButton:
#		if event.is_pressed():
#			pass
#	pass # Replace with function body.






