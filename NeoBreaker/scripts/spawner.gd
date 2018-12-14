extends Position2D

var monster_scene = preload("res://scenes//monster.tscn")


func _spawn():
	var monster = monster_scene.instance()
	monster.position = self.position
	get_parent().add_child(monster)
