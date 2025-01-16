extends Sprite2D

class_name Hammer


var speed: float = 1200.0 
var direction = Vector2()
var canMove: bool = true
var last_mouvement = Vector2.ZERO
func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if canMove:
		if Input.is_action_pressed("down"):
			direction = Vector2(0, speed)
			canMove=false
		elif Input.is_action_pressed("up"):
			direction = Vector2(0, -speed)
			canMove=false
		elif Input.is_action_pressed("left"):
			direction = Vector2(-speed, 0)
			canMove=false
		elif Input.is_action_pressed("right"):
			direction = Vector2(speed, 0)
			canMove=false
		
	if direction != Vector2.ZERO:
		look_at(position + direction)
		if(!$Detection.is_colliding()):
			position += direction * delta
		else:
			canMove = true
func _change_tile_set():
	
	
