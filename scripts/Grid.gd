extends Node2D
export var on = true
var columns = 30
var rows = 16
var windowHeight = 1920
var windowWidth = 1024
func _draw():
	if on: 
		#var size = get_viewport_rect().size  * get_parent().get_node("Camera2D").zoom / 2
		#var cam = get_parent().get_node("Camera2D").position
		for i in range(0,columns):
			draw_line(Vector2(i * 64,0), Vector2(i * 64,windowWidth), "#FFFFFF")
		for i in range(0,rows):
			draw_line(Vector2(0, i * 64), Vector2(windowHeight, i * 64), "#FFFFFF")

#func _process(delta):
#	update()
