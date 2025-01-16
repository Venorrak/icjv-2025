extends Node2D
#signal setNextBody
@export var body : Node2D
var lastBodyState : Array = []

func _ready() -> void:
	SignalBus.connect("setNextBody", setNextBody)
	
func requestNextBody(asker : Node) -> Array:
	return body.getPlayerSkin()

func setNextBody(value : Array) -> void:
	body.setPlayerSkin(value)

func _physics_process(delta: float) -> void:
	if body.playerSkin != lastBodyState:
		lastBodyState = body.playerSkin
		SignalBus.nextBodyStatus.emit(body.playerSkin)
