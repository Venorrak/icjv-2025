extends Node2D

var progressBar: ProgressBar
var timer: Timer
signal win
signal lose

func _ready() -> void:
	progressBar = get_node("ProgressBar")


func _process(delta: float) -> void:
	if progressBar.value == 100:
		win.emit()
	if progressBar.value == 0:
		lose.emit()
