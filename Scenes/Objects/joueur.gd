extends CharacterBody2D


@onready var trail = load("res://Scenes/Objects/queue.tscn")
@onready var snake = get_tree().get_root().get_node("Snake")

var speed = 400
var tile_size = 64
var move_distance = 0
var last_direction = ""
var previous_direction = ""
var fin = false
var map_size_x = 18
var map_size_y = 10
var input_dir = Vector2.ZERO
var array_position = []
var array_direction = []
var array_trail = []
var point_counter = 0

@onready var trail_texture_1 = preload("res://Rescources/Textures/turn_snake_20250116113842.png")
@onready var trail_texture_2 = preload("res://Rescources/Textures/tileset_snake_20250116110621 (1).png")
@onready var sprite: Sprite2D = $Trail_Sprite

func get_input():
	input_dir = Vector2.ZERO

	if (Input.is_action_pressed("ui_left") && last_direction != "right"):
		input_dir.x = -1
		if (last_direction != "left"):
			previous_direction = last_direction
			last_direction = "left"
		previous_direction = last_direction
		
	elif Input.is_action_pressed("ui_right")  && last_direction != "left":
		input_dir.x = 1
		if (last_direction != "right"):
			previous_direction = last_direction
			last_direction = "right"
		previous_direction = last_direction
	elif Input.is_action_pressed("ui_up")  && last_direction != "down":
		input_dir.y = -1
		if (last_direction != "up"):
			previous_direction = last_direction
			last_direction = "up"
		previous_direction = last_direction
	elif Input.is_action_pressed("ui_down")  && last_direction != "up":
		input_dir.y = 1
		if (last_direction != "down"):
			previous_direction = last_direction
			last_direction = "down"
		previous_direction = last_direction
	
	
	if (input_dir.x == 0 && input_dir.y == 0):
		if (last_direction == "left"):
			go_left()
		elif (last_direction == "right"):
			go_right()
		elif (last_direction == "down"):
			go_down()
		elif (last_direction == "up"):
			go_up()
	velocity = input_dir.normalized() * speed
	
	if (fin):
		velocity = input_dir.normalized() * 0


func _physics_process(delta):
	if (move_distance == 0):
		get_input()
	move_and_collide(velocity * delta)
	get_direction()
	var movement = (velocity * delta)
	move_distance += movement.length()
	if (move_distance > tile_size):
		move_distance = 0
		self.global_position.x = round(self.global_position.x / tile_size) * tile_size
		var position_x = self.global_position.x
		self.global_position.y = round(self.global_position.y / tile_size) * tile_size
		var position_y = self.global_position.y
		var test = [position_x, position_y]
		array_position.insert(0,test)
		array_direction.insert(0, last_direction)
		var instance = trail.instantiate()
		instance.global_position.x = array_position.front()[0] + 32
		instance.global_position.y = array_position.front()[1] + 32
		
		var sprite = instance.get_node("Trail_Sprite")
		if sprite:
			sprite.texture = trail_texture_2 if previous_direction == last_direction else trail_texture_1
			if previous_direction == last_direction:
				sprite.texture = trail_texture_2
				if (last_direction == "left" || last_direction == "right"):
					instance.rotation = deg_to_rad(90)
			else:
				sprite.texture = trail_texture_1
				if ((last_direction == "left" && previous_direction == "down") || (previous_direction == "right" && last_direction == "up")):
					instance.rotation = deg_to_rad(90)
					pass
				elif ((last_direction == "down" && previous_direction == "right") || (previous_direction == "up" && last_direction == "left")):
					pass
				elif ((last_direction == "right" && previous_direction == "down") || (previous_direction == "left" && last_direction == "up")):
					instance.rotation = deg_to_rad(180)
				elif ((last_direction == "right" && previous_direction == "up") || (previous_direction == "left" && last_direction == "down")):
					instance.rotation = deg_to_rad(270)
		
		array_trail.insert(0, instance)
		snake.add_child.call_deferred(instance)
		
		#var last_segment = array_trail.pop_back()
		#last_segment.queue_free()
	
	var count = array_position.size()
	if (count > point_counter):
		array_position.remove_at(array_position.size() -1)
		array_trail.remove_at(array_trail.size() -1)
		#if (array_trail.size() != 0):
			#var last_segment = array_trail.pop_back()
			#last_segment.queue_free()

func get_direction():
	var input_dir = Vector2.ZERO

	if (Input.is_action_pressed("ui_left") && last_direction != "right"):
		last_direction = "left"
	elif Input.is_action_pressed("ui_right")  && last_direction != "left":
		last_direction = "right"
	elif Input.is_action_pressed("ui_up")  && last_direction != "down":
		last_direction = "up"
	elif Input.is_action_pressed("ui_down")  && last_direction != "up":
		last_direction = "down"


func go_left():
	if (last_direction != "left"):
		previous_direction = last_direction
		last_direction = "left"
	previous_direction = last_direction
	input_dir.x = -1

func go_right():
	if (last_direction != "right"):
		previous_direction = last_direction
		last_direction = "right"
	previous_direction = last_direction
	input_dir.x = 1

func go_up():
	if (last_direction != "up"):
		previous_direction = last_direction
		last_direction = "up"
	previous_direction = last_direction
	input_dir.y = -1

func go_down():
	if (last_direction != "down"):
		previous_direction = last_direction
		last_direction = "down"
	previous_direction = last_direction
	input_dir.y = 1

func _on_mur_haut_area_entered(area: Area2D) -> void:
	fin = true


func _on_mur_bas_area_entered(area: Area2D) -> void:
	fin = true


func _on_mur_gauche_area_entered(area: Area2D) -> void:
	fin = true


func _on_mur_droite_area_entered(area: Area2D) -> void:
	fin = true


func _on_point_area_entered(area: Area2D) -> void:
	point_counter += 1
