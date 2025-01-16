extends ColorRect
class_name Player

@export var maxSpeed : float = -600
@export var acceleration := 0.02
@export var fallSpeed : float = 600
var currentSpeed : float = 0
var minBox : float = 500.0
var topBox: float = -500.0

func _process(delta: float) -> void:
	
	if Input.is_action_pressed("ui_accept"):
		currentSpeed = lerp(currentSpeed, maxSpeed, acceleration)
	else:
		currentSpeed = lerp(currentSpeed ,fallSpeed, acceleration)
	if (position.y>=topBox && position.y<=minBox):
		position.y += currentSpeed * delta
	if (position.y<=topBox):
		position.y += -currentSpeed * delta
	if (position.y>=minBox):
		position.y += -currentSpeed * delta

	
