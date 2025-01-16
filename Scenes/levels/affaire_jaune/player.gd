extends RigidBody2D
class_name Player
var wall : TileSet
var speed: float = 10000.0 
var direction = Vector2.ZERO

func _ready() -> void:
	connect("body_entered", self, "_on_hitbox_body_entered")
	pass
func _process(delta: float) -> void:
	if direction != Vector2.ZERO:
		move_and_collide(direction * delta)
		


func _on_hitbox_body_entered(body: Node2D) -> void:
	if (body is TileMap): 
		if Input.is_action_pressed("ui_down"):
			direction = Vector2(0, speed)
		elif Input.is_action_pressed("ui_up"):
			direction = Vector2(0, -speed)
		elif Input.is_action_pressed("ui_left"):
			direction = Vector2(-speed, 0)
		elif Input.is_action_pressed("ui_right"):
			direction = Vector2(speed, 0)
			
