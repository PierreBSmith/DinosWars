extends Unit

func _ready():
	self.move_range = 3
	self.friendly = Unit_type.ENEMY
	self.attackDamage = 2
	self.hp = 15

