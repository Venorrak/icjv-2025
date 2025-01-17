extends Node

var tirroirOpened : bool = false
var currentWave : int = 1
var futureCharacter : Array = []
var darkMode : bool = false

@export var difficultyCurve : Curve

func reset() -> void:
	tirroirOpened = false
	currentWave = 1
	futureCharacter = []
