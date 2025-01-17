extends Node2D

var point = 0
var rng = RandomNumberGenerator.new()
var velocity = Vector2.ZERO
var gravity = Vector2(0, 200)
var speed_ini = Vector2(rng.randf_range(-100, 100), rng.randf_range(-500, -400))
var life = 3
var difficulty = 0
@export var target : PackedScene

@onready var timer : Timer = $Timer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#var cursor_texture = preload("res://Scenes/levels/Fruit_ninja/Sprite/Cursor_Sprite.png")
	#Input.set_custom_mouse_cursor(cursor_texture)
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	$Label.text = str("Points: " + str(point))
	$Label2.text = str("Nombre de vie: " + str(life))
	timer.wait_time = 1.5 - (difficulty * 0.01)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_timer_timeout() -> void:
	var target_inst = target.instantiate()
	target_inst.position = Vector2(rng.randf_range(50, 1000), 640)
	target_inst.linear_velocity = Vector2(rng.randf_range(-100, 100), rng.randf_range(-1000, -800))
	var Sprite = rng.randi_range(0, 11)
	var sprite_node = target_inst.get_node("Sprite2D")
	if sprite_node and sprite_node is Sprite2D:
		var sprite_frame = rng.randi_range(0, 11)
		sprite_node.frame = sprite_frame
	self.add_child(target_inst)


func _on_cursor_body_entered(body: Node2D) -> void:
	if body.is_in_group("target"):
		var sprite_node = body.get_node("Sprite2D")
		if (sprite_node.frame  >= 4 && sprite_node.frame < 8):
			point -= 2
			print(point)
			body.queue_free()
		else:
			point += 1
			print(point)
			body.queue_free()
		$Label.text = str("Points: " + str(point))


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("target"):
		var sprite_node = body.get_node("Sprite2D")
		if (sprite_node.frame  >= 4 && sprite_node.frame < 8):
			body.queue_free()
		else:
			life -= 1
			$Label2.text = str("Nombre de vie: " + str(life))
