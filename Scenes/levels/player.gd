extends Sprite2D

class_name Player


var speed: float = 5000.0 
var direction = Vector2()
var canMove: bool = true
var last_mouvement = Vector2.ZERO
func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if canMove:
		if Input.is_action_pressed("down"):
			direction = Vector2(0, speed)
			look_at(position + direction) 
			canMove=false
		elif Input.is_action_pressed("up"):
			direction = Vector2(0, -speed)
			look_at(position + direction) 
			canMove=false
		elif Input.is_action_pressed("left"):
			direction = Vector2(-speed, 0)
			look_at(position + direction) 
			canMove=false
		elif Input.is_action_pressed("right"):
			direction = Vector2(speed, 0)
			look_at(position + direction) 
			canMove=false
		print("Collision détectée, mouvement débloqué.")
		last_mouvement = direction
		look_at(position + direction)
		
	if direction != Vector2.ZERO:
		while not $Detection.is_colliding():
			position += last_mouvement * delta
			print("Aucune Collision détectée, mouvement bloqué.")
		canMove = true

	
	
