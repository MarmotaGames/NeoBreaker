extends Sprite

var monster_scene = preload("res://scenes//monster.tscn")
var bullet_scene = preload("res://scenes//bullet.tscn")
var sceneManager_scene = preload("res://scenes//sceneManager.tscn")
var gameOver_scene = preload("res://scenes//gameOver.tscn")
var angulo
var turno
var bolas = 0
var ballsLeft
var spawnou
var gameOver
var canPlay
var level = 0
var jogadasPassadas = []
var arrayDeCoisasGrandes = [6, 7, 8, 9]

func _ready():
	canPlay = true

func _shoot():
	var timer = get_node("Timer")
	var bullet = bullet_scene.instance()
	bullet.set_name("Bullet" + str(ballsLeft))
	bullet.position = self.position
	get_parent().add_child(bullet)
	
	if ballsLeft == bolas:
		turno = true

	ballsLeft -= 1
	
	if ballsLeft == 0:
		timer.stop()
		yield(get_tree().create_timer(0.2), "timeout")
		turno = false
		spawnou = false
	
func sorteia():
	var N = 8
#	var dist_array = [5,7,9,13,17,11,6,50]
	var dist_array = [3,4,5,8,8,7,4,2]
	var soma = 0
	var soma2 = 0
	var sorteio = 0
	var i = 0
	
	for j in range(N):
		soma += dist_array[j]
		
	randomize()
	var S = floor(rand_range(0, soma-1))
	
	
	while soma2 <= S:
		soma2 = soma2 + dist_array[i]
		sorteio = sorteio + 1
		i+=1
# 	print(sorteio)
	return sorteio

func _process(delta):
#	if sorteia() == 0:
#		print("lul")

	#resets the highscore
#	get_parent().get_parent().save(0)

#	spawner(level)
	
	if gameOver:
		gameOver = false
		print("perdeu playboy")
		
		#parent da torre eh o main
		get_parent().queue_free()
		
		if get_parent().score > get_parent().get_parent().read_savegame():
			get_parent().get_parent().save(get_parent().score)
			get_parent().get_parent().newRecord = true
		else:
			get_parent().get_parent().newRecord = false
		
		var gameOverScreen = gameOver_scene.instance()
		#parent do parent da torre eh o sceneManager
		get_parent().get_parent().add_child(gameOverScreen)
		
#		get_node("res://scenes//sceneManager.tscn").save()
		
#		var newMainScene = sceneManager_scene.instance()
#
#		#parent do main eh o sceneManager
#		get_parent().get_parent().add_child(newMainScene)
		
	var childNodes = get_parent().get_children()
	var hasBalls = false
	
	for child in childNodes:
		if "Bullet" in child.name:
			hasBalls = true

	if not hasBalls:
#		turno = false
		if not spawnou:
			spawnou = true
			level +=1
			get_parent().level = level
			spawner(level)
			if bolas == null:
				bolas = 0
			bolas += 1
			childNodes = get_parent().get_children()
			for child in childNodes:
				if "Scatter" in child.name:
					child.queue_free()
				elif "Monster" in child.name:
					child.position.y += 33*0.75
#					if child.position.y >= 18 + 33*4:
					if child.position.y >= (18 + 33*11)*0.75:
						gameOver = true
		
#		canPlay = true
		
#		print(sorteia())
		
func spawner(level):
	canPlay = true
	randomize()
	
	#lidar depois com peso de possiveis numeros de quadrados
	
#	var randomNumberOfMonsters = (randi()%8)+1
	var randomNumberOfMonsters = sorteia()
	
	if len(jogadasPassadas) >= 3:
		for i in arrayDeCoisasGrandes:
			if i in jogadasPassadas:
				while randomNumberOfMonsters >=6:
					randomNumberOfMonsters = sorteia()
				
	if len(jogadasPassadas) > 2:
		jogadasPassadas.pop_front()
		
	jogadasPassadas.append(randomNumberOfMonsters)
		
	var monsterPositionArray = []
	
	for i in range(randomNumberOfMonsters):
		var randomNumberPosition = (randi()%9)
		
		while randomNumberPosition in monsterPositionArray:
			randomNumberPosition = (randi()%9)
			
		monsterPositionArray.append(randomNumberPosition)
		
	for j in range(randomNumberOfMonsters):
		var monster = monster_scene.instance()
		monster.set_name("Monster" + str(j))
		
		monster.position.x = (monsterPositionArray[j]*33 + 19)*0.75
		monster.position.y = 18
		
		monster.health = level
		
		get_parent().add_child(monster)
		
func getAngle(event):
	if not turno:
		var mousepos = event.position
		var deltaX =  mousepos.x - self.position.x*2
		var deltaY =  -1*(mousepos.y - self.position.y*2)
		if deltaY == 0:
			deltaY = 0.001
		var angulo = (atan(deltaX/deltaY))
#		if angulo > (PI/3):
#			angulo = PI/3
#		elif angulo < (-PI/3):
#			angulo = -PI/3
		return angulo

func _input(event):
	#shoot with space
#	if event.is_action_pressed("ui_select") and canPlay:
		
	#shoot with mouse
	if event.is_action_pressed("shoot_bullet") and canPlay and get_parent().get_parent().titleOff:
		canPlay = false
		var timer = get_node("Timer")
		ballsLeft = bolas
		timer.start()
		turno = true
	
	if event is InputEventMouseMotion and not turno:
#		var angulo = getAngle(event)
		var mousepos = event.position
		var deltaX =  mousepos.x - self.position.x*2
		var deltaY =  -1*(mousepos.y - self.position.y*2)
		if deltaY == 0:
			deltaY = 0.001
		angulo = (atan(deltaX/deltaY))
		if angulo > (PI/2.5):
			angulo = PI/2.5
		elif angulo < (-PI/2.5):
			angulo = -PI/2.5
		self.rotation = angulo