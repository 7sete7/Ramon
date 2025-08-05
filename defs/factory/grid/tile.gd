class_name Tile
extends RefCounted

var center_position: Vector2i
var tilemap_position: Vector2i

var id: String
var tile_size: Vector2i
var tile_type_str: String = "Blank"

var building: Building

var tile_type: FactoryEnums.TILES:
	set(value):
		tile_type = value
		match self.tile_type:
			FactoryEnums.TILES.DEFAULT:
				self.tile_type_str = "Blank"
			FactoryEnums.TILES.GREEN:
				self.tile_type_str = "Green"
			FactoryEnums.TILES.RED:
				self.tile_type_str = "Red"
			FactoryEnums.TILES.YELLOW:
				self.tile_type_str = "Yellow"
			_:
				self.tile_type_str = "Vish"

func _init(tilemap_pos: Vector2i, type: FactoryEnums.TILES, tile_sizes: Vector2i):
	self.tile_type = type
	self.tile_size = tile_sizes
	
	self.tilemap_position = tilemap_pos
	self.center_position = tilemap_position * tile_size + (tile_size / 2)
	self.id = "%v" % self.tilemap_position
