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

func push_item_to_output(output_side: Vector2i, item: Item) -> bool:
	if not output_side in self._output:
		push_error("Building %s does not output to side: %s" % [self.name, output_side])
		return false

	var new_tile: Tile = GameFactory.grid.get_tile_at(self.tile.tilemap_position + output_side)
	if not new_tile:
		push_error("No tile at %s" % (self.tile.position + output_side))
		return false
	
	print("{} - push item to tile {}".format([self.tilemap_position, new_tile.tilemap_position], "{}"))
	if not new_tile.building: return false
	return new_tile.building.input_item_from_input(output_side * -1, item)

func input_item_from_input(input_side: Vector2i, item: Item) -> bool:
	if not input_side in self._input:
		push_warning("Input side not valid: %s" % input_side)
		return false

	return true
