extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	get_node("newRecordSprite").hide()
	pass

func _process(delta):
	get_node("LabelScore").set_text(str(get_parent().score))
	get_node("LabelHighScore").set_text(str(get_parent().read_savegame()))
	
	if get_parent().newRecord:
		get_node("newRecordSprite").show()
	else:
		get_node("newRecordSprite").hide()
		