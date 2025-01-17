extends Label

@export var timer : Timer

func _physics_process(delta: float) -> void:
	text = str(int(timer.time_left)) + " s" 
