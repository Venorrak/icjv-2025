extends Node

var tirroirOpened : bool = false
var currentWave : int = 1
var futureCharacter : Array = []
var darkMode : bool = false
var baseRoundTime : float = 160
var roundTime : float = 160

@export var difficultyCurve : Curve
@export var mainMenu : PackedScene
@export var deathMenu : PackedScene
@export var morgue : PackedScene

func reset() -> void:
	tirroirOpened = false
	currentWave = 1
	futureCharacter = []
	roundTime = baseRoundTime
