extends Area2D

var map_size_x = 17
var map_size_y = 9
var point_x = 0
var point_y = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_entered(area: Area2D) -> void:
	point_x = randi_range(0, map_size_x)
	point_y = randi_range(0, map_size_y)
	self.global_position.x = ((point_x * 64) + 10)
	self.global_position.y = ((point_y * 64) + 10)
