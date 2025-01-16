extends Node2D

@export var torso : Sprite2D
@export var leftLeg : Sprite2D
@export var rightLeg : Sprite2D
@export var leftArm : Sprite2D
@export var rightArm : Sprite2D
@export var head : Sprite2D
@export var randomise : bool
@export var bloodEmitter : CPUParticles2D

var creatureType : String
var playerSkin : Array = []

var spriteReference : Dictionary = {
	"vampire": {
		"leg": 2,
		"arm": 1,
		"torso": 0,
		"head": 3
	},
	"zombie": {
		"leg": 6,
		"arm": 5,
		"torso": 4,
		"head": 7
	},
	"werewolf": {
		"leg": 14,
		"arm": 13,
		"torso": 12,
		"head": 15
	},
	"parrain": {
		"leg": 10,
		"arm": 9,
		"torso": 8,
		"head": 11
	}
}

func _ready() -> void:
	if randomise:
		randomiseBody()

func setParrain() -> void:
	for i in get_children():
		i.visible = true
	torso.frame = spriteReference["parrain"]["torso"]
	rightArm.frame = spriteReference["parrain"]["arm"]
	leftArm.frame = spriteReference["parrain"]["arm"]
	leftLeg.frame = spriteReference["parrain"]["leg"]
	rightLeg.frame = spriteReference["parrain"]["leg"]
	head.frame = spriteReference["parrain"]["head"]

func getPlayerSkin() -> Array:
	return playerSkin

func setPlayerSkin(props : Array) -> void:
	if props.size() < getParts().size():
		bloodEmitter.emitting = true
	playerSkin = props
	for sprites in get_children():
		sprites.visible = false
	bloodEmitter.visible = true
	for prop in props:
		match prop["part"]:
			"torso":
				torso.frame = spriteReference[prop["type"]]["torso"]
				torso.visible = true
			"leftLeg":
				leftLeg.frame = spriteReference[prop["type"]]["leg"]
				leftLeg.visible = true
			"rightLeg":
				rightLeg.frame = spriteReference[prop["type"]]["leg"]
				rightLeg.visible = true
			"leftArm":
				leftArm.frame = spriteReference[prop["type"]]["arm"]
				leftArm.visible = true
			"rightArm":
				rightArm.frame = spriteReference[prop["type"]]["arm"]
				rightArm.visible = true
			"head":
				head.frame = spriteReference[prop["type"]]["head"]
				head.visible = true

func randomiseBody() -> void:
	var type : int = randi_range(0, 2)
	match type:
		0:
			creatureType = "vampire"
		1:
			creatureType = "zombie"
		2:
			creatureType = "werewolf"
	if doesBodyPartExist():
		torso.frame = spriteReference[creatureType]["torso"]
		torso.visible = true
	if doesBodyPartExist():
		leftLeg.frame = spriteReference[creatureType]["leg"]
		leftLeg.visible = true
	if doesBodyPartExist():
		rightLeg.frame = spriteReference[creatureType]["leg"]
		rightLeg.visible = true
	if doesBodyPartExist():
		leftArm.frame = spriteReference[creatureType]["arm"]
		leftArm.visible = true
	if doesBodyPartExist():
		rightArm.frame = spriteReference[creatureType]["arm"]
		rightArm.visible = true
	if doesBodyPartExist():
		head.frame = spriteReference[creatureType]["head"]
		head.visible = true

func doesBodyPartExist() -> bool:
	var rand : float = randf_range(0.0, 100.0)
	if rand < (100 - GlobalVars.difficultyCurve.sample(float(GlobalVars.currentWave) / 100)):
		return true
	return false

func getParts() -> Array:
	var parts : Array = []
	if torso.visible:
		parts.append({"part": "torso", "type": creatureType})
	if leftLeg.visible:
		parts.append({"part": "leftLeg", "type": creatureType})
	if rightLeg.visible:
		parts.append({"part": "rightLeg", "type": creatureType})
	if leftArm.visible:
		parts.append({"part": "leftArm", "type": creatureType})
	if rightArm.visible:
		parts.append({"part": "rightArm", "type": creatureType})
	if head.visible:
		parts.append({"part": "head", "type": creatureType})
	return parts
