extends Control

@export var playButton : TextureButton
@export var quitButton : TextureButton
@export var booSound : AudioStream
var morgue : PackedScene = GlobalVars.morgue
var menu : PackedScene = GlobalVars.mainMenu

func _ready() -> void:
	playButton.grab_focus()
	AudioManager.playSound(booSound)
	
func _on_play_button_button_up() -> void:
	get_tree().change_scene_to_packed(morgue)

func _on_quit_button_button_up() -> void:
	get_tree().quit()

func _on_menu_button_button_up() -> void:
	get_tree().change_scene_to_packed(menu)
