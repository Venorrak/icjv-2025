extends Node2D

@export var tirroir : PackedScene
@export var width : float
@export var quantity : int
@export var passedDir : String

func _ready() -> void:
	for i in quantity:
		var newTirroir := tirroir.instantiate()
		newTirroir.position.x = getTirroirPosition(i)
		add_child(newTirroir)
		newTirroir.get_child(0).direction = passedDir
		
func getTirroirPosition(index : int) -> float:
	return ((width * float(index + 1)) / float(quantity + 1)) - 20
