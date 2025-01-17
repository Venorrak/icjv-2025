extends RigidBody2D


var rng = RandomNumberGenerator.new()
var SPEED = 300.0
var direction = Vector2.ZERO
var velocity = Vector2.ZERO
var speed_ini = Vector2(rng.randf_range(-100, 100), rng.randf_range(-500, -350))
var target = preload("res://Scenes/levels/Fruit_ninja/target_2.tscn")
var gravity = 200

func _ready():
	pass
