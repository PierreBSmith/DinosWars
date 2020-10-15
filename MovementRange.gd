extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var selected = null
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func setSelected(selected_unit):
	selected = selected_unit
	self.update()

func _draw():
	if selected != null:
		for i in range(-selected.moveRange, selected.moveRange + 1):
			for j in range(-(selected.moveRange - abs(i)),selected.moveRange - abs(i) + 1): 
				draw_rect(Rect2(Vector2(selected.position[0] + i*64,selected.position[1] + j*64), Vector2(64,64)),Color("#0000FF"), true)
				if abs(i) + abs(j) >= selected.moveRange:
					draw_rect(Rect2(Vector2(selected.position[0] + (i + 1)*64,selected.position[1] + j*64), Vector2(64,64)),Color("#FF0000"), true)
					draw_rect(Rect2(Vector2(selected.position[0] + -(i + 1)*64,selected.position[1] + -(j)*64), Vector2(64,64)),Color("#FF0000"), true)
		draw_rect(Rect2(Vector2(selected.position[0],selected.position[1] + (selected.moveRange + 1)*64), Vector2(64,64)),Color("#FF0000"), true)
		draw_rect(Rect2(Vector2(selected.position[0],selected.position[1] - (selected.moveRange + 1)*64), Vector2(64,64)),Color("#FF0000"), true)
