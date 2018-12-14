extends Button

var sceneManager_scene = preload("res://scenes//sceneManager.tscn")
# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_MenuButton_pressed():
		#parent do botao eh o gameOver
		get_parent().queue_free()
		var newSceneManagerScene= sceneManager_scene.instance()

		#parent do gameOver eh o screenManager
		get_parent().get_parent().add_child(newSceneManagerScene)
		get_parent().get_parent().titleOff = false