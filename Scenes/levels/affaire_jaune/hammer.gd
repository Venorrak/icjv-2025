extends Sprite2D

class_name Hammer


var speed: float = 1200.0 
var direction = Vector2()
var canMove: bool = true
var last_mouvement = Vector2.ZERO
func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if canMove:
		if Input.is_action_pressed("down"):
			direction = Vector2(0, speed)
			canMove=false
		elif Input.is_action_pressed("up"):
			direction = Vector2(0, -speed)
			canMove=false
		elif Input.is_action_pressed("left"):
			direction = Vector2(-speed, 0)
			canMove=false
		elif Input.is_action_pressed("right"):
			direction = Vector2(speed, 0)
			canMove=false
		
	if direction != Vector2.ZERO:
		look_at(position + direction)
		if(!$Detection.is_colliding()):
			position += direction * delta
		else:
			canMove = true
	
	#get_collider_rid() const
#Returns the RID of the first object that the ray intersects, or an empty RID if no object is intersecting the ray (i.e. is_colliding() returns false).
#TileMapLayerscript
#void_tile_data_runtime_update(coords: Vector2i, tile_data: TileData) virtualbool_use_tile_data_runtime_update(coords: Vector2i) virtualvoidclear()voiderase_cell(coords: Vector2i)voidfix_invalid_tiles()intget_cell_alternative_tile(coords: Vector2i) constVector2iget_cell_atlas_coords(coords: Vector2i) constintget_cell_source_id(coords: Vector2i) constTileDataget_cell_tile_data(coords: Vector2i) constVector2iget_coords_for_body_rid(body: RID) const
