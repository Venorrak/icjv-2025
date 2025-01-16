extends Node2D
@export var pressLabel : Label
@export var animator : AnimationPlayer
@export var width : float
@export var shakeStrength : float
@export var particles : CPUParticles2D

var direction : String = ""
var playerWithin : bool = false

func _on_player_detect_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		pressLabel.visible = true
		playerWithin = true

func _on_player_detect_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		pressLabel.visible = false
		playerWithin = false
		
func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("interact") and playerWithin:
		applyOpenEffects()
		animator.play("open")
		
func applyOpenEffects() -> void:
	var shakeDirection : Vector2
	match direction:
		"up":
			shakeDirection = Vector2(0, 1 * shakeStrength)
		"down":
			shakeDirection = Vector2(0, -1 * shakeStrength)
		"left":
			shakeDirection = Vector2(1 * shakeStrength, 0)
		"right":
			shakeDirection = Vector2(-1 * shakeStrength, 0)
	SignalBus.directionShake.emit(shakeDirection)
	particles.emitting = true
