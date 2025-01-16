extends Node2D
#signal setNextBody
@export var body : Node2D

func _ready() -> void:
	SignalBus.connect("setNextBody", setNextBody)
	
func requestNextBody(asker : Node) -> Array:
	return body.getPlayerSkin()

func setNextBody(value : Array) -> void:
	body.setPlayerSkin(value)
