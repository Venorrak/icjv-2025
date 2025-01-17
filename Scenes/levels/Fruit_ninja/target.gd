extends CharacterBody2D

var rng = RandomNumberGenerator.new()
var SPEED = 300.0
var direction = Vector2.ZERO
var gravity = Vector2(0, 200)
var speed_ini = Vector2(rng.randf_range(-100, 100), rng.randf_range(-300, -200))

func _ready():
	pass

func _physics_process(delta):
	velocity += gravity * delta
	position += velocity * delta
	if (position.y > 700):
		velocity = Vector2(0,0)
		position.y = 640
		velocity = Vector2(rng.randf_range(-100, 100), rng.randf_range(-350, -250))

	move_and_slide()
