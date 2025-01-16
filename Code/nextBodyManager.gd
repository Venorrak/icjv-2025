extends Node2D
#signal requestNextBody
#signal setNextBody
@export var body : Node2D

func _ready() -> void:
	SignalBus.connect("requestNextBody", requestNextBody)
	SignalBus.connect("setNextBody", setNextBody)
	
func requestNextBody(asker : Node) -> Array:
	return body.getPlayerSkin()

func setNextBody(value : Array) -> void:
	body.setPlayerSkin(value)
