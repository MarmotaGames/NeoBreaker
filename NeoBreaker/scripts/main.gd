extends YSort
#var sceneManager = preload("res://scenes//main.tscn")

var score = 0
var level = 1
var highscore = 0


func _ready():
	var sceneManager = get_parent()
#	print(sceneManager)
	highscore = sceneManager.read_savegame()
	
func _process(delta):
	get_node("LabelScore").set_text("Score: " + str(score))
	get_node("LabelHighscore").set_text("HighScore: " + str(highscore))
	
	get_parent().score = score
