class_name Building

#General
var ID: String
var name: String
var description: String

#Tilemap
var tileset_id: int
var tileset_tile_id: int

#Economy
var currency: FactoryEnums.Currency = FactoryEnums.Currency.MONEY
var price: float = 0.0

#Offset
var tile_sprite_offset: Vector2

var tilemap_position: Vector2i

func _init() -> void:
	pass

func load_from_resource(resource: BuildingResource) -> void:
	self.ID = resource.ID
	self.name = resource.name
	self.description = resource.description
	self.tileset_id = resource.tileset_id
	self.tileset_tile_id = resource.tileset_tile_id
	self.tile_sprite_offset = resource.tile_sprite_offset

func should_place(tilemap_position: Vector2i) -> bool:
	return false
	
static func get_resource_location() -> String:
	push_error("get_resource_location() must be implemented in the subclass")
	return ""

func on_placed() -> void:
	pass
	
func on_tick() -> void:
	pass
