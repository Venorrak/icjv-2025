extends Node2D
@export var nextBody : Node2D
@export var deathScene : PackedScene
@export var spawnHelpersBase : Node2D

@export var imgDayWindow : Texture2D
@export var imgNightWindow : Texture2D
@export var dark : Sprite2D
@export var window : Sprite2D

func _ready() -> void:
	if GlobalVars.darkMode:
		dark.visible = true
		window.texture = imgNightWindow
	else:
		dark.visible = false
		window.texture = imgDayWindow

func _on_round_timer_timeout() -> void:
	GlobalVars.reset()
	get_tree().change_scene_to_packed(deathScene)

func _on_check_tirroir_timeout() -> void:
	for spawnHelper in spawnHelpersBase.get_children():
		for tirroir in spawnHelper.get_children():
			if not tirroir.get_child(0).hasBeenOpened:
				return
	refreshTirroirs()
	
func refreshTirroirs() -> void:
	for spawnHelper in spawnHelpersBase.get_children():
		for tirroir in spawnHelper.get_children():
			tirroir.queue_free()
		spawnHelper.generate()
