extends Node2D

var progressBar: ProgressBar
var timer: Timer
signal finished

func _ready() -> void:
	progressBar = get_node("ProgressBar")


func _process(delta: float) -> void:
	if progressBar.value == 100:
		finished.emit(true)
		queue_free()
	if progressBar.value == 0:
		finished.emit(false)
		queue_free()
