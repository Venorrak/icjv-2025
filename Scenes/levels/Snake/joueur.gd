extends CharacterBody2D

var speed = 400
var tile_size = 64
var move_distance = 0
var last_direction = ""
var fin = false
var map_size_x = 18
var map_size_y = 10
var input_dir = Vector2.ZERO

func get_input():
	input_dir = Vector2.ZERO

	if (Input.is_action_pressed("ui_left") && last_direction != "right"):
		input_dir.x = -1
		last_direction = "left"
	elif Input.is_action_pressed("ui_right")  && last_direction != "left":
		input_dir.x = 1
		last_direction = "right"
	elif Input.is_action_pressed("ui_up")  && last_direction != "down":
		input_dir.y = -1
		last_direction = "up"
	elif Input.is_action_pressed("ui_down")  && last_direction != "up":
		input_dir.y = 1
		last_direction = "down"
	
	
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
		self.global_position.y = round(self.global_position.y / tile_size) * tile_size

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
	input_dir.x = -1

func go_right():
	input_dir.x = 1

func go_up():
	input_dir.y = -1

func go_down():
	input_dir.y = 1

func _on_mur_haut_area_entered(area: Area2D) -> void:
	print("La collision haut à été touché")
	fin = true


func _on_mur_bas_area_entered(area: Area2D) -> void:
	print("La collision bas à été touché")
	fin = true


func _on_mur_gauche_area_entered(area: Area2D) -> void:
	print("La collision gauche à été touché")
	fin = true


func _on_mur_droite_area_entered(area: Area2D) -> void:
	print("La collision droite à été touché")
	fin = true
