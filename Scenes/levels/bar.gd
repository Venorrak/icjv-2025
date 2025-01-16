extends Sprite2D



@export var maxSpeed : float = -600
@export var acceleration := 0.02
@export var fallSpeed : float = 600
var currentSpeed : float = 0

func _process(delta: float) -> void:
	

	position.y += currentSpeed * delta
	
func _on_timer_timeout() -> void:
	var random_y : float = randf_range(10.0,200.0)
	if(random_y > position.y):
		position.y = lerp(currentSpeed, maxSpeed, acceleration)
	else:
		position.y =lerp(currentSpeed ,fallSpeed, acceleration)
		
	
