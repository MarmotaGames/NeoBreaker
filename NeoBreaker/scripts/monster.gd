extends KinematicBody2D

var health = 10
var vel = Vector2(0,0)

func _process(delta):
	get_node("Label").set_text(str(self.health))




#func _die():
#	health = 3

