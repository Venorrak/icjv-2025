extends Sprite2D
class_name Bar

@export var progressBar: ProgressBar
@export var maxSpeed : float = -300
@export var acceleration := 0.01
@export var fallSpeed : float = 300
var progress: float = 0
@export var progressSpeed: float = 15

var player: Player
var currentSpeed : float = 0
var minBox : float = 500.0
var topBox: float = -500.0
var random_y:float

func _ready() -> void:
	player = get_parent().get_node("Player")
	progressBar = get_parent().get_node("ProgressBar")

func _process(delta: float) -> void:
	
	if(random_y < position.y):
		currentSpeed = lerp(currentSpeed, maxSpeed, acceleration)
	else:
		currentSpeed = lerp(currentSpeed ,fallSpeed, acceleration)
	if (position.y>=topBox && position.y<=minBox):
		position.y += currentSpeed * delta
	if (position.y<=topBox):
		position.y += -currentSpeed * delta
	if (position.y>=minBox):
		position.y += -currentSpeed * delta

	if(position.y >= player.position.y && position.y <= player.position.y + player.size.y):
		print("JE SUIS LA")
		progress += progressSpeed * delta
		progress = clamp(progress, 0, 100)
		progressBar.value = progress
	else:
		print(progress)
		progress -= progressSpeed * delta
		progress = clamp(progress, 0, 100)
		progressBar.value = progress

func _on_timer_timeout() -> void:
	random_y  = randf_range(-500.0,500.0)

	

	
