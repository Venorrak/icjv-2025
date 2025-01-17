extends AnimatedSprite2D

var direction := Vector2.ZERO
var acceleration:=0.01
var currentSpeed:float=0
var upSpeed:float = 200
var downSpeed:float = -200


func _ready() -> void:
	pass


func _process(delta: float) -> void:
	
	
	pass


func _on_hit_box_body_entered(body: Node2D) -> void:
	var area_name := body.name.to_lower()
	
	if (area_name == "level"):
		currentSpeed = lerp(direction.y,upSpeed,acceleration)
		position+=direction*currentSpeed
	else:
		currentSpeed = lerp(direction.y,downSpeed,acceleration)
	print(area_name)
