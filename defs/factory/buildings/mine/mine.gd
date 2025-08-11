class_name FactoryMine
extends Building

var ore_produces: Dictionary[FactoryEnums.TILES, Callable] = {
	FactoryEnums.TILES.GREEN:  func(): return ItemManager.get_item("green"),
	FactoryEnums.TILES.RED:    func(): return ItemManager.get_item("red"),
	FactoryEnums.TILES.YELLOW: func(): return ItemManager.get_item("yellow")
}

const TICKS_PER_PRODUCE: int = 2
var current_tick: int = 0

func _init() -> void:
	super ()
	self._output = [Vector2i.RIGHT]

static func get_resource_location() -> String:
	return "res://defs/factory/buildings/mine/mine_resource.tres"

func can_place_at(tilemap_position: Vector2i) -> bool:
	var tile: Tile = GameFactory.grid.get_tile_at(tilemap_position)
	return tile.building == null and tile.tile_type in self.ore_produces

func on_placed(_tile: Tile) -> void:
	super(_tile)
	
func on_tick() -> void:
	if current_tick == TICKS_PER_PRODUCE:
		self.current_tick = 0
		var item_output_fn: Callable = self.ore_produces.get(self.tile.tile_type)
		if not item_output_fn: return
		
		var item_output = item_output_fn.call()
		if item_output is Item:
			self.push_item_to_output(Vector2i.RIGHT, item_output)
	else:
		self.current_tick += 1
