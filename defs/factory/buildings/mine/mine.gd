class_name FactoryMine
extends Building

var allowed_tiles: Array[FactoryEnums.TILES] = [
	FactoryEnums.TILES.GREEN,
	FactoryEnums.TILES.RED,
	FactoryEnums.TILES.YELLOW
]

func _init() -> void:
	super ()

static func get_resource_location() -> String:
	return "res://defs/factory/buildings/mine/mine_resource.tres"

func can_place_at(tilemap_position: Vector2i) -> bool:
	var tile: Tile = GameFactory.grid.get_tile_at(tilemap_position)
	return tile.building == null and tile.tile_type in self.allowed_tiles

func on_placed(_tile: Tile) -> void:
	super(_tile)
	
func on_tick() -> void:
	pass
