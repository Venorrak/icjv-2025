extends CharacterBody2D

var direction := Vector2()

var speed: int= 1000
var acceleration:float= 0.05
var friction:float= 0.2

signal finish

var score:int =0

func _process(delta: float) -> void:
	direction = Input.get_vector("left","right","up", "down")
	direction.normalized()
	if(direction.length()>0):
		velocity = velocity.lerp(direction*speed, acceleration)
	else:
		velocity = velocity.lerp(Vector2.ZERO, friction)
	$Texture.rotation = velocity.angle()
	move_and_slide()
	if score == 5:
		finish.emit(true)
		get_parent().queue_free()

func _on_hammer_box_area_entered(area: Area2D) -> void:
	if(area.get_parent() is RigidBody2D):
		area.get_parent().queue_free()
		score+=1
		


func _on_timer_timeout() -> void:
	finish.emit(false)
	get_parent().queue_free()
	pass # Replace with function body.
