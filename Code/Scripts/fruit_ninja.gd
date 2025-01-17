extends Node2D
signal finished

var point = 0
var rng = RandomNumberGenerator.new()
var velocity = Vector2.ZERO
var gravity = Vector2(0, 200)
var speed_ini = Vector2(rng.randf_range(-100, 100), rng.randf_range(-500, -400))
var life = 3
var difficulty = GlobalVars.difficultyCurve.sample(float(GlobalVars.currentWave) / 100)
@export var target : PackedScene

@export var sprite : PackedScene 
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
	match Sprite:
		0:
			target_inst.type = "Stanley"
		1:
			target_inst.type = "Lapin"
		2:
			target_inst.type = "Epee"
		3:
			target_inst.type = "Rat"
		4:
			target_inst.type = "Coeur"
		5:
			target_inst.type = "Foie"
		6:
			target_inst.type = "Cerveau"
		7:
			target_inst.type = "Intestin"
		8:
			target_inst.type = "Poulet"
		9:
			target_inst.type = "Banane"
		10:
			target_inst.type = "Animal"
		11:
			target_inst.type = "Lit"
	var sprite_node = target_inst.get_node("Sprite2D")
	if sprite_node and sprite_node is Sprite2D:
		sprite_node.frame = Sprite
	self.add_child(target_inst)


func _on_cursor_body_entered(body: Node2D) -> void:
	if body.is_in_group("target"):
		
		var piece_inst1 = sprite.instantiate()
		var piece_inst2 = sprite.instantiate()
		piece_inst1.position = body.position
		piece_inst1.position += Vector2(rng.randf_range(-50, 50), rng.randf_range(-50, 50))
		piece_inst1.linear_velocity = Vector2(rng.randf_range(-100, 100), rng.randf_range(-100, -100))
		
		piece_inst2.position = body.position
		piece_inst2.position += Vector2(rng.randf_range(-50, 50), rng.randf_range(-50, 50))
		piece_inst2.linear_velocity = Vector2(rng.randf_range(-100, 100), rng.randf_range(-100, -100))
		
		var sprite_inst1 = piece_inst1.get_node("Sprite2D")
		var sprite_inst2 = piece_inst2.get_node("Sprite2D")
		
		var sprite_node = body.get_node("Sprite2D")
		if (sprite_node.frame  >= 4 && sprite_node.frame < 8):
			point -= 2
			if body.type == "Coeur":
				sprite_inst1.frame = 8
				sprite_inst2.frame = 9
			
			elif body.type == "Foie":
				sprite_inst1.frame = 10
				sprite_inst2.frame = 11
			
			elif body.type == "Cerveau":
				sprite_inst1.frame = 16
				sprite_inst2.frame = 17
			
			elif body.type == "Intestin":
				sprite_inst1.frame = 18
				sprite_inst2.frame = 19
			
		else:
			point += 1
			if body.type == "Stanley":
				sprite_inst1.frame = 0
				sprite_inst2.frame = 1
				
			elif body.type == "Lapin":
				sprite_inst1.frame = 2
				sprite_inst2.frame = 3
				
			elif body.type == "Epee":
				sprite_inst1.frame = 4
				sprite_inst2.frame = 5
				
			elif body.type == "Rat":
				sprite_inst1.frame = 6
				sprite_inst2.frame = 7
				
			elif body.type == "Poulet":
				sprite_inst1.frame = 12
				sprite_inst2.frame = 13
				
			elif body.type == "Banane":
				sprite_inst1.frame = 14
				sprite_inst2.frame = 15
				
			elif body.type == "Animal":
				sprite_inst1.frame = 20
				sprite_inst2.frame = 21
				
			elif body.type == "Lit":
				sprite_inst1.frame = 22
				sprite_inst2.frame = 23
		body.queue_free()
		self.add_child(piece_inst1)
		self.add_child(piece_inst2)
		$Label.text = str("Points: " + str(point))
		if point >= 10:
			finished.emit(true)
			queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("target"):
		var sprite_node = body.get_node("Sprite2D")
		if (sprite_node.frame  >= 4 && sprite_node.frame < 8):
			body.queue_free()
		else:
			life -= 1
			$Label2.text = str("Nombre de vie: " + str(life))
			if life <= 0:
				finished.emit(false)
				queue_free()
