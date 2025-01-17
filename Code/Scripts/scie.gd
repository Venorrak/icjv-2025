extends Sprite2D
class_name Scie

@export var maxSpeed : float = -600
@export var acceleration := 0.02
@export var fallSpeed : float = 600
var currentSpeed : float = 0
var minBox : float = 408.0
var topBox: float = 119.0

func _process(delta: float) -> void:
	
	if Input.is_action_pressed("ui_accept"):
		currentSpeed = lerp(currentSpeed, maxSpeed, acceleration)
	else:
		currentSpeed = lerp(currentSpeed ,fallSpeed, acceleration)
	if (position.y>=topBox && position.y<=minBox):
		position.y += currentSpeed * delta
	if (position.y<=topBox):
		position.y = topBox
		currentSpeed = 0
	if (position.y>=minBox):
		position.y = minBox
		currentSpeed = 0
