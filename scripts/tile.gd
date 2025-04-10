class_name Tile
extends RefCounted

var center_position: Vector2i
var tilemap_position: Vector2i

var tile_id: FactoryGrid.TILES
var tile_size: Vector2i

func _init(tilemap_pos: Vector2i, id: FactoryGrid.TILES, tile_sizes: Vector2i):
	tile_id = id
	tile_size = tile_sizes
	
	tilemap_position = tilemap_pos
	center_position = tilemap_position * tile_size + (tile_size / 2)
