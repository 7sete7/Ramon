class_name Building

#General
var ID: String
var name: String
var description: String
var texture: Texture2D

#Tilemap
var tileset_id: int
var tileset_tile_id: int
var tilemap_position: Vector2i
var tile: Tile

#Economy
var currency: FactoryEnums.Currency = FactoryEnums.Currency.MONEY
var price: float = 0.0

# I/O
# I/O is represented using directions, from the building perspective (Vector2i.LEFT, ...)
var _input: Array[Vector2i]
var _output: Array[Vector2i]

func _init() -> void:
	pass

func load_from_resource(resource: BuildingResource) -> void:
	self.ID = resource.ID
	self.name = resource.name
	self.description = resource.description
	self.tileset_id = resource.tileset_id
	self.tileset_tile_id = resource.tileset_tile_id
	self.texture = resource.texture

func can_place_at(tilemap_position: Vector2i) -> bool:
	return false
	
static func get_resource_location() -> String:
	push_error("get_resource_location() must be implemented in the subclass")
	return ""

func on_placed(_tile: Tile) -> void:
	self.tile = _tile
	
func on_tick() -> void:
	pass

func on_remove() -> void:
	pass
