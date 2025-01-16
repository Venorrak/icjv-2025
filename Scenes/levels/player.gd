extends Sprite2D

class_name Player

var speed: float = 1000.0 
var direction = Vector2()
var canMove: bool = true

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if canMove:
		if Input.is_action_pressed("down"):
			direction = Vector2(0, speed)
		elif Input.is_action_pressed("up"):
			direction = Vector2(0, -speed)
		elif Input.is_action_pressed("left"):
			direction = Vector2(-speed, 0)
		elif Input.is_action_pressed("right"):
			direction = Vector2(speed, 0)
		else:
			direction = Vector2.ZERO 

		if direction != Vector2.ZERO:
			var next_position = position + direction * delta

			if !is_colliding_with_obstacle(next_position):
				position = next_position 
				look_at(position + direction) 
			else:
				print("Collision détectée, mouvement bloqué.")
			
			canMove = false

	
	if !is_colliding_with_obstacle(position):
		canMove = true 
		print("Direction:", direction)
		print("Position X:", position.x)
		print("Position Y:", position.y)

func is_colliding_with_obstacle(next_position: Vector2) -> bool:
	return $Detection.is_colliding()
