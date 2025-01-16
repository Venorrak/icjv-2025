extends Node2D
@export var pressLabel : Label
@export var animator : AnimationPlayer
@export var width : float
@export var shakeStrength : float
@export var particles : CPUParticles2D
@export var body : Node2D

var direction : String = ""
var members : Array = []
var playerWithin : bool = false

func _ready() -> void:
	members = body.getParts()

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
		
func opened() -> void:
	if not members.is_empty() and needsParts():
		SignalBus.getFocus.emit(get_parent())
		SignalBus.freezePlayer.emit(true)
	else:
		animator.play("close")

func needsParts() -> bool:
	return true
	#TODO : check if we need part when main corpse is done

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
