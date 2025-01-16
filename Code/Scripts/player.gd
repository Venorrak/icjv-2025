extends RigidBody2D
@export var speed : float

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	linear_velocity = direction * speed
