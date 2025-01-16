extends Node2D
#signal setNextBody
@export var body : Node2D
var lastBodyState : Array = []

var playerWithin : bool = false
@export var pressLabel : Sprite2D

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
	if Input.is_action_just_pressed("interact") and body.playerSkin.size() == 6 and playerWithin:
		GlobalVars.futureCharacter = body.getPlayerSkin()
		GlobalVars.currentWave += 1
		SignalBus.newLoop.emit()

func _on_area_2d_body_entered(value: Node2D) -> void:
	if value.is_in_group("player"):
		playerWithin = true
		if body.playerSkin.size() == 6:
			pressLabel.visible = true

func _on_area_2d_body_exited(value: Node2D) -> void:
	if value.is_in_group("player"):
		playerWithin = false
		if body.playerSkin.size() == 6:
			pressLabel.visible = false
