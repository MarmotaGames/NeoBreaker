extends Node

#var main_scene = preload("res://scenes//main.tscn")

var savegame = File.new() #file
var save_path = "user://savegame.save" #place of the file
var save_data = 0 #variable to store data
var score
var newRecord = false
var titleOff = false

func _ready():
	save_data = 0 #variable to store data
	
	if not savegame.file_exists(save_path):
		create_save()
	
	if titleOff:
		get_node("TitleSprite").hide()
	else:
		get_node("TitleSprite").show()
		
		

#var save_data = {"highscore": 0} #variable to store data

func create_save():
	savegame.open(save_path, File.WRITE)
	savegame.store_var(save_data)
	savegame.close()
	
func save(high_score):    
	save_data = high_score #data to save
#	save_data["highscore"] = high_score #data to save
	savegame.open(save_path, File.WRITE) #open file to write
	savegame.store_var(save_data) #store the data
	savegame.close() # close the file

func read_savegame():
	savegame.open(save_path, File.READ) #open the file
	save_data = savegame.get_var() #get the value
	savegame.close() #close the file
	return save_data #return the value
#	return save_data["highscore"] #return the value