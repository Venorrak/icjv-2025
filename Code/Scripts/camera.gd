extends Camera2D
var directionShakeStrength : Vector2 = Vector2(0, 0)
var targetDirecShake : Vector2 = Vector2(0, 0)
@export var shakeDecayRate : float

func _ready() -> void:
	SignalBus.connect("directionShake", applyDirectionShake)

func _physics_process(delta: float) -> void:
	if abs(offset.length() - targetDirecShake.length()) < 1.0:
		targetDirecShake = lerp(targetDirecShake, Vector2.ZERO, shakeDecayRate) * -1
	offset = lerp(offset, targetDirecShake, 0.8)
func applyDirectionShake(dir : Vector2) -> void:
	targetDirecShake = dir
