extends Node2D
@export var pressLabel : Sprite2D
@export var lockedLabel : Sprite2D
@export var animator : AnimationPlayer
@export var width : float
@export var shakeStrength : float
@export var particles : CPUParticles2D
@export var body : Node2D
@export var cursor : Sprite2D
@export var timer : Timer
@export var openingSound : AudioStream
@export var takeMemberSound : AudioStream
@export var lockedSound : AudioStream
@export var booSound : AudioStream

@export var armMiniGame : PackedScene
@export var legMiniGame : PackedScene
@export var torsoMiniGame : PackedScene
@export var headMiniGame : PackedScene

var direction : String = ""
var members : Array = []
var playerWithin : bool = false
var nextBody : Array = []

var cursorIndex : int = 0
var cursorOn : String = ""
var chosenPart : Dictionary = {}

var isOpen : bool = false
var hasBeenOpened : bool = false
var isInMiniGame : bool = false

var arrowPositions : Dictionary = {
	"head" : {
		"position" : Vector2(20, 10),
		"rotation" : 68.6
	},
	"torso" : {
		"position": Vector2(17, 26),
		"rotation": 34.3
	},
	"rightArm": {
		"position": Vector2(31, 50),
		"rotation": 75.4
	},
	"rightLeg": {
		"position": Vector2(26, 93),
		"rotation": 109.7
	},
	"leftLeg": {
		"position": Vector2(-29, 90),
		"rotation": 253.7
	},
	"leftArm": {
		"position": Vector2(-31, 35),
		"rotation": -61.7
	}
}

func _ready() -> void:
	members = body.getParts()
	SignalBus.connect("nextBodyStatus", updateNextBodyStatus)

func _on_player_detect_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		if hasBeenOpened or not needsParts():
			lockedLabel.visible = true
		else:
			pressLabel.visible = true
		playerWithin = true

func _on_player_detect_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		pressLabel.visible = false
		lockedLabel.visible = false
		playerWithin = false
		
func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("interact") and playerWithin and not isInMiniGame:
		if isOpen:
			selectMember()
		else:
			if not hasBeenOpened and needsParts():
				AudioManager.playSound(openingSound, 1, 0.12)
				applyOpenEffects()
				animator.play("open")
			else:
				hasBeenOpened = true
				AudioManager.playSound(lockedSound)
	if Input.is_action_just_pressed("interact") and cursor.visible and not isInMiniGame:
		selectMember()
	if Input.is_action_just_pressed("ui_up") and cursorOn != "" and cursor.visible:
		if cursorIndex > 0:
			cursorIndex -= 1
		else:
			cursorIndex = arrowPositions.keys().size() - 1
	if Input.is_action_just_pressed("ui_down") and cursorOn != "" and cursor.visible:
		if cursorIndex == arrowPositions.keys().size() - 1:
			cursorIndex = 0
		else:
			cursorIndex += 1
	if cursorOn != "":
		cursorOn = arrowPositions.keys()[cursorIndex]
		cursor.position = arrowPositions[cursorOn]["position"]
		cursor.rotation_degrees = arrowPositions[cursorOn]["rotation"]
	
func updateCursorData() -> void:
	var typesPossesed : Array = []
	var nextBodyPossed : Array = []
	for member in members:
		typesPossesed.append(member["part"])
	for part in nextBody:
		nextBodyPossed.append(part["part"])
		
	for type in arrowPositions.keys():
		if not typesPossesed.has(type) or nextBodyPossed.has(type):
			arrowPositions.erase(type)
	if arrowPositions.keys().size() > 0:
		cursorOn = arrowPositions.keys()[cursorIndex]
	
func opened() -> void:
	if not members.is_empty() and needsParts() and not hasBeenOpened and not GlobalVars.tirroirOpened:
		GlobalVars.tirroirOpened = true
		isOpen = true
		SignalBus.getFocus.emit(get_parent())
		SignalBus.freezePlayer.emit(true)
		updateCursorData()
		cursor.visible = true
	else:
		animator.play("close")
	hasBeenOpened = true

func updateNextBodyStatus(value : Array) -> void:
	nextBody = value

func needsParts() -> bool:
	for item in members:
		if not hasThisPart(item):
			return true
	return false

func hasThisPart(part : Dictionary) -> bool:
	for nextPart in nextBody:
		if nextPart["part"] == part["part"]:
			return true
	return false

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

func takeMember(memberName : String) -> Dictionary:
	for member in members:
		if member["part"] == memberName:
			members.erase(member)
			body.setPlayerSkin(members)
			AudioManager.playSound(takeMemberSound)
			return member
	return {} #crashes

func selectMember() -> void:
	isInMiniGame = true
	chosenPart = takeMember(cursorOn)
	match cursorOn:
		"torso":
			SignalBus.startMiniGame.emit(self, torsoMiniGame)
		"head":
			SignalBus.startMiniGame.emit(self, headMiniGame)
		"leftArm":
			SignalBus.startMiniGame.emit(self, armMiniGame)
		"rightArm":
			SignalBus.startMiniGame.emit(self, armMiniGame)
		"leftLeg":
			SignalBus.startMiniGame.emit(self, legMiniGame)
		"rightLeg":
			SignalBus.startMiniGame.emit(self, legMiniGame)

func onMiniGameFinished(won : bool) -> void:
	if chosenPart != {}:
		if won:
			nextBody.append(chosenPart)
			SignalBus.setNextBody.emit(nextBody)
		else:
			AudioManager.playSound(booSound, 0.5)
		SignalBus.getFocus.emit(null)
		SignalBus.freezePlayer.emit(false)
		cursor.visible = false
		isOpen = false
		GlobalVars.tirroirOpened = false
		timer.start()
	isInMiniGame = false

func _on_time_to_see_timeout() -> void:
	animator.play("close")
	AudioManager.playSound(lockedSound)
	pressLabel.visible = false
