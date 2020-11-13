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

#draws movement range when unit is selected
func _draw():
	if selected != null:
		for i in range(-selected.move_range - selected.attackRange, selected.move_range + selected.attackRange + 1):
			for j in range(-(selected.move_range - abs(i) + selected.attackRange),selected.move_range - abs(i) + selected.attackRange + 1):
				if  selected.friendly == Unit_type.FRIENDLY and abs(j) + abs(i) <= selected.move_range: #draws movement range
					draw_rect(Rect2(Vector2(selected.position[0] + i*64,selected.position[1] + j*64), Vector2(64,64)),Color("#0000FF"), true)
				elif selected.friendly == Unit_type.ENEMY or abs(j) + abs(i) > selected.move_range: #draws attack range
					draw_rect(Rect2(Vector2(selected.position[0] + i*64,selected.position[1] + j*64), Vector2(64,64)),Color("#FF0000"), true)
