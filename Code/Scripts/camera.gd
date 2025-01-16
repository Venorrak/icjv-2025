extends Camera2D
var directionShakeStrength : Vector2 = Vector2(0, 0)
var targetDirecShake : Vector2 = Vector2(0, 0)
@export var shakeDecayRate : float
@export var player : RigidBody2D
@export var cameraSpeed : float
var target : Node2D

func _ready() -> void:
	target = player
	SignalBus.connect("directionShake", applyDirectionShake)
	SignalBus.connect("getFocus", changeTarget)

func _physics_process(delta: float) -> void:
	global_position = lerp(global_position, target.global_position, cameraSpeed)
	global_rotation_degrees = lerp(global_rotation_degrees, target.global_rotation_degrees, cameraSpeed)
	updateShake()
	
func updateShake() -> void:
	if abs(offset.length() - targetDirecShake.length()) < 1.0:
		targetDirecShake = lerp(targetDirecShake, Vector2.ZERO, shakeDecayRate) * -1
	offset = lerp(offset, targetDirecShake, 0.8)
	
func applyDirectionShake(dir : Vector2) -> void:
	targetDirecShake = dir

func changeTarget(node : Node2D) -> void:
	target = node
