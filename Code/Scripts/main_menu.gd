extends Control
@export var playButton : TextureButton
@export var quitButton : TextureButton
@export var title : Sprite2D

@export var morgue : PackedScene

var frameMov : int = 1

func _ready() -> void:
	playButton.grab_focus()

func _on_timer_timeout() -> void:
	if title.frame == title.hframes - 1:
		frameMov = -1
	if title.frame == 0:
		frameMov = 1
	title.frame += frameMov

func _on_play_button_button_up() -> void:
	get_tree().change_scene_to_packed(morgue)

func _on_quit_button_button_up() -> void:
	get_tree().quit()
