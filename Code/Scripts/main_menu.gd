extends Control
@export var playButton : TextureButton
@export var quitButton : TextureButton
@export var howToButton : TextureButton
@export var dayNightButton : TextureButton
@export var title : Sprite2D
@export var howToSection : Control

@export var fondEcran : Texture2D
@export var fondEcranNuit : Texture2D
@export var imgBtnNight : Texture2D
@export var imgBtnDay : Texture2D

@export var morgue : PackedScene

var frameMov : int = 1
var inHow : bool = false

func _ready() -> void:
	playButton.grab_focus()
	updateDN()

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel") and inHow:
		changeVisibility()
func _on_timer_timeout() -> void:
	if title.frame == title.hframes - 1:
		frameMov = -1
	if title.frame == 0:
		frameMov = 1
	title.frame += frameMov

func updateDN() -> void:
	if GlobalVars.darkMode:
		dayNightButton.texture_normal = imgBtnNight
		$FondEcran.texture = fondEcranNuit
	else:
		dayNightButton.texture_normal = imgBtnDay
		$FondEcran.texture = fondEcran

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

func _on_day_night_button_button_down() -> void:
	GlobalVars.darkMode = !GlobalVars.darkMode
	updateDN()
