extends Node2D
@export var nextBody : Node2D
@export var deathScene : PackedScene

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		if nextBody.getParts().size() == 6:
			GlobalVars.futureCharacter = nextBody.getPlayerSkin()
			GlobalVars.currentWave += 1
			get_tree().reload_current_scene()

func _on_round_timer_timeout() -> void:
	GlobalVars.reset()
	get_tree().change_scene_to_packed(deathScene)
