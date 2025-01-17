extends AnimatedSprite2D

@export var maxSpeed : float = 300
@export var acceleration := 0.01
@export var difficulte = 1
var currentSpeed : float = 0
var direction = Vector2()
var goTop :bool=true
func _ready() -> void:
	pass

func _process(delta: float) -> void:
	
	direction = Vector2(0, currentSpeed)
	if direction != Vector2.ZERO:
		look_at(position + direction)
	
	if($Detection.is_colliding()):
		if(goTop):
			currentSpeed = lerp(direction, maxSpeed, acceleration)
			
			position += direction * delta
			goTop=false
			
		else:
			position -= direction * delta
			goTop=true


	
