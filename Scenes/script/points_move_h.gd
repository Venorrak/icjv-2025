extends RigidBody2D

@export var acceleration := 0.01
@export var difficulte = 40/10
@export var maxSpeed : float = -100*difficulte

var currentSpeed : float = 0
var direction = Vector2()
var area_name:String

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	
	direction = Vector2( maxSpeed,0)
	position.x += maxSpeed * delta


func _on_hitbox_body_entered(body: Node2D) -> void:
	area_name = body.name.to_lower()
	if(area_name=="level"):
		scale.x*=-1
		maxSpeed*=-1
	
