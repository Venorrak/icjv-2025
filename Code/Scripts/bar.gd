extends Sprite2D
class_name Bar

var progressBar: ProgressBar
@export var background : Sprite2D
@export var maxSpeed : float = -300
@export var acceleration := 0.01
@export var fallSpeed : float = 300
var progress: float = 25
@export var progressSpeed: float = 15

var player: Scie
var currentSpeed : float = 0
var minBox : float = 539.0
var topBox: float = 119.0
var random_y:float   
@export var difficulte = 40

func _ready() -> void:
	player = get_parent().get_node("Scie")
	progressBar = get_parent().get_node("ProgressBar")
	maxSpeed = difficulte * -4 - 140
	fallSpeed = difficulte * 4 + 140

func _process(delta: float) -> void:
	updateBackground()
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

	if(position.y >= player.position.y && position.y <= player.position.y +100):
		progress += progressSpeed * delta
		progress = clamp(progress, 0, 100)
		progressBar.value = progress
	else:
		progress -= progressSpeed * delta
		progress = clamp(progress, 0, 100)
		progressBar.value = progress

func _on_timer_timeout() -> void:
	random_y  = randf_range(topBox,minBox)

func updateBackground() -> void:
	background.frame = int(lerp(0, 5, progressBar.value / 100))

	
