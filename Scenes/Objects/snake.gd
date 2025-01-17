extends Node2D

var point_counter = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_point_area_entered(area: Area2D) -> void:
	point_counter += 1
	$Label.text = str(point_counter)
