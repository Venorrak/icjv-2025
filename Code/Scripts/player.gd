extends RigidBody2D
@export var speed : float

var frozen : bool = false

func _ready() -> void:
	if GlobalVars.futureCharacter == []:
		$Body.setParrain()
	else:
		$Body.setPlayerSkin(GlobalVars.futureCharacter)
	SignalBus.connect("freezePlayer", setFrozen)

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if not frozen:
		linear_velocity = direction * speed

func setFrozen(value : bool) -> void:
	frozen = value
