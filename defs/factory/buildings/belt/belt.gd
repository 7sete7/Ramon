class_name FactoryBelt
extends Building

func _init() -> void:
	super ()

static func get_resource_location() -> String:
	return "res://defs/factory/buildings/belt/belt_resource.tres"

func can_place_at(tilemap_position: Vector2i) -> bool:
	var tile: Tile = GameFactory.grid.get_tile_at(tilemap_position)
	return tile.building == null
	
func on_placed(_tile: Tile) -> void:
	super(_tile)
	
func on_tick() -> void:
	pass
