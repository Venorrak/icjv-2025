extends Control
@export var playButton : TextureButton
@export var quitButton : TextureButton
@export var howToButton : TextureButton
@export var title : Sprite2D
@export var howToSection : Control

@export var morgue : PackedScene

var frameMov : int = 1
var inHow : bool = false

func _ready() -> void:
	playButton.grab_focus()

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel") and inHow:
		changeVisibility()
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

func _on_how_to_button_button_up() -> void:
	changeVisibility()
	inHow = true

func changeVisibility() -> void:
	playButton.visible = !playButton.visible
	howToButton.visible = !howToButton.visible
	quitButton.visible = !quitButton.visible
	title.visible = !title.visible
	howToSection.visible = !howToSection.visible
