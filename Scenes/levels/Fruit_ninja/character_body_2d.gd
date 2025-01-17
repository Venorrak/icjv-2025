extends CharacterBody2D

func _ready():
	pass


func _physics_process(delta: float) -> void:
	move_and_collide(get_global_mouse_position() - global_position)
