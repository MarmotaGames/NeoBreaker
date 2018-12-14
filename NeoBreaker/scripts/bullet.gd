extends KinematicBody2D

var scatter_scene = preload("res://scenes//scatter.tscn")
var teta
var x
var y
var inicializa = 0
var vel
var reflect = true
var bounce_coefficent = 1.0
var velocidade
var hitInVain = 0
var hasScatter = false
var scattersCreated = 0
var scattersFound = 0

func _physics_process(delta):
	if not inicializa:
		velocidade = 925

		var teta = get_parent().get_node("canhao").angulo
		if not teta:
			teta = 0.00000000000001
		x = velocidade * sin(teta)
		y = -velocidade * cos(teta)
		inicializa = 1
		vel = Vector2(x,y)
		
	if x:
		var collision = move_and_collide(vel * delta)
		if collision:
			if "Monster" in collision.collider.name:
				hitInVain = 0
				if collision.collider.health == 1:
					collision.collider.queue_free()
					get_parent().score += 1
				else:
					var childNodes = get_parent().get_children()
					for child in childNodes:
						if child.name == collision.collider.name:
							child.health -= 1
			elif "ParedeTeto" in collision.collider.name:
				hitInVain = 0
			elif "Parede" in collision.collider.name:
				hitInVain += 1
				
			var motion = collision.remainder.bounce(collision.normal)
			vel = vel.bounce(collision.normal)
			move_and_collide(motion)
			
	if self.position.y * 2 > get_viewport().size.y:
		self._die()
			
	if hitInVain >= 10:
		var children = get_parent().get_children()
		var scatter = scatter_scene.instance()
		scatter.set_name("Scatter")
		scatter.position.x = 150
		
		if self.vel.y > 0:
			scatter.position.y = self.position.y + 15
		else:
			scatter.position.y = self.position.y - 15
			
		for child in children:
			if "Bullet" in child.name:
				child.hitInVain = 0
			
		scattersCreated += 1
		hasScatter = false
		get_parent().add_child(scatter)

func _die():
	self.queue_free()
