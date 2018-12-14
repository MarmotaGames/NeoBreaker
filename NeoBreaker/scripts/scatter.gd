extends Area2D

func _scatterBullets(body):
	var velocidade = 925
	var teta = rand_range(-PI/2, PI/2)
	
	var x = velocidade * sin(teta)
	var y = -velocidade * cos(teta)
	body.vel = Vector2(x,y)

	
