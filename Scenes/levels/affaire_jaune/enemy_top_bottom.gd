extends Sprite2D

@export var maxSpeed : float = -100
@export var acceleration := 0.01
@export var difficulte = 1
var currentSpeed : float = 0
var direction = Vector2()
var area_name:String
func _ready() -> void:
	pass

func _process(delta: float) -> void:
	
	direction = Vector2(-maxSpeed, 0)
	position.y += maxSpeed * delta

func _on_hit_box_body_entered(body: Node2D) -> void:
	area_name = body.name.to_lower()
	if(area_name=="level"):
		scale.y*=-1
		maxSpeed*=-1
	
