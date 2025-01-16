extends Sprite2D

class_name Player

var speed: float = 1000.0 
var direction = Vector2()

func _ready() -> void:
	pass
func _process(delta: float) -> void:
	
	if Input.is_action_pressed("ui_down"):
		direction = Vector2(0, speed)
		
		if $RayCast2D.is_colliding():
			position+=Vector2(0,0)
		else:
			position+=direction*delta
	elif Input.is_action_pressed("ui_up"):
		direction = Vector2(0, -speed)
		
		if $RayCast2D.is_colliding():
			position+=Vector2(0,0)
		else:
			position+=direction*delta
	elif Input.is_action_pressed("ui_left"):
		direction = Vector2(-speed, 0)
		
		if $RayCast2D.is_colliding():
			position+=Vector2(0,0)
		else:
			position+=direction*delta
	elif Input.is_action_pressed("ui_right"):
		direction = Vector2(speed, 0)
		if $RayCast2D.is_colliding():
			position+=Vector2(0,0)
		else:
			position+=direction*delta
	if direction.length() > 0:
		look_at(position + direction) 
	print("Direction: ",direction)
	print("Position X:",position.x)
	print("Position Y:",position.y)
	


func _on_hitbox_body_entered(body: Node2D) -> void:
	pass
