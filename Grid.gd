extends Node2D
export var on = true

func _draw():
	if on: 
		#var size = get_viewport_rect().size  * get_parent().get_node("Camera2D").zoom / 2
		#var cam = get_parent().get_node("Camera2D").position
		for i in range(0,20):
			draw_line(Vector2(i * 64,0), Vector2(i * 64,768), "000000")
		for i in range(0,12):
			draw_line(Vector2(0, i * 64), Vector2(1280, i * 64), "000000")

func _process(delta):
	update()
